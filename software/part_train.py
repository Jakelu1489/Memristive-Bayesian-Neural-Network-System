from __future__ import print_function

import os
import argparse

import torch
from torch import Tensor
import numpy as np
from torch.optim import Adam, lr_scheduler
from torch.nn import functional as F

import data
import layers
import utils
import metric
import config_quan as cfg
import time
import random
import json

from models.BayesianModel.Bay3Conv3FC import BBB3Conv3FC
from models.BayesianModel.BayAlexNet import BBBAlexNet
from models.BayesianModel.BayLeNet import BBBLeNet
from models.BayesianModel.BayCNN import ModelTest
from tqdm import tqdm

import quan

os.environ['CUDA_VISIBLE_DEVICES'] = '1'
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")


def init_seeds(seed):
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)


def get_model(net_type, inputs, outputs, priors, layer_type, activation_type, clt, clt_num, model_path):
    if net_type == "lenet":
        model = BBBLeNet(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
        return model.state_dict(model_path)
    elif net_type == "alexnet":
        model = BBBAlexNet(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
        return model.state_dict(model_path)
    elif net_type == "3conv3fc":
        model = BBB3Conv3FC(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
        return model.state_dict(model_path)
    elif net_type == "test":
        model = ModelTest(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
        model = model.load_state_dict(torch.load(model_path))
        return model
    else:
        raise ValueError("Other Network do not supported")


def train_model(net, optimizer, criterion, train_loader, num_ens=1, beta_type=0.1, epoch=None, num_epochs=None):
    net.train()
    training_loss = 0.0
    accs = []
    kl_list = []
    inputs = torch.tensor(np.load("part_train/train_features.npy"))
    with open("part_train/label_ol.json", "r") as f:
        labels = torch.from_numpy(np.array(json.load(f))[:1000].reshape(10, -1))
    # print(inputs.shape)
    for i in range(inputs.shape[0]):
        optimizer.zero_grad()

        x, y = inputs[i].to(device), labels[i].to(device)
        outputs = torch.zeros(100, net.num_classes, num_ens).to(device)

        kl = 0.0

        for j in range(num_ens):
            x_inp = x[j].view(100, -1)
            x_ = x_inp + torch.normal(0.0, 2.6, (100, 128)).to(device)
            x_inp = torch.where(x_inp == 0.0, 0.0, x_).float()
            net_out, _kl = net(x_inp)
            kl += _kl
            outputs[:, :, j] = F.log_softmax(net_out, dim=1)

        kl /= num_ens
        if isinstance(kl, Tensor):
            kl_list.append(kl.cpu().detach().numpy())
        else:
            kl_list.append(kl)
        # kl_list.append(kl)
        log_outputs = utils.logmeanexp(outputs, dim=2)

        beta = metric.get_beta(i - 1, 10, beta_type, epoch, num_epochs)
        loss = criterion(log_outputs, y, kl, beta)
        loss.backward()
        # for name, params in net.named_parameters():
        #     print("--> name:", name, "--> grad_requirs: ", params.requires_grad, "--> grad value: ", params.grad)
        optimizer.step()

        accs.append(metric.acc(log_outputs.data, y))
        training_loss += loss.cpu().detach().numpy()  # * inputs.size(0)

    return training_loss / len(train_loader), np.mean(accs), np.mean(kl_list)


def validate_model(net, criterion, valid_loader, num_ens=1, beta_type=0.1, epoch=None, num_epochs=None):
    net.train()
    valid_loss = 0.0
    accs = []

    # valid_loader = tqdm(valid_loader)
    inputs = torch.tensor(np.load("part_train/test_features.npy")).float()
    with open("attack_dataset/Bay_clt_10_noise/gaussian/eps_0.1_adv_label.json", "r") as f:
        lab = np.array((json.load(f)))
        labels = np.concatenate((lab[6000:7000], lab[7100:]))
        labels = torch.from_numpy(labels).reshape(inputs.shape[0], -1)
    for i in range(inputs.shape[0]):

        x, y = inputs[i].to(device), labels[i].to(device)
        outputs = torch.zeros(100, net.num_classes, num_ens).to(device)

        kl = 0.0

        for j in range(num_ens):
            x_inp = x[j].view(100, -1)
            net_out, _kl = net(x_inp)
            kl += _kl
            outputs[:, :, j] = F.log_softmax(net_out, dim=1)

        kl /= num_ens
        log_outputs = utils.logmeanexp(outputs, dim=2)

        beta = metric.get_beta(i - 1, 10, beta_type, epoch, num_epochs)
        loss = criterion(log_outputs, y, kl, beta)

        accs.append(metric.acc(log_outputs.data, y))
        valid_loss += loss.cpu().detach().numpy()

    return valid_loss / len(valid_loader), np.mean(accs)


def model_test(net, criterion, test_loader, num_ens=1, beta_type=0.1, epoch=None, num_epochs=None):
    net.eval()
    test_loss = 0.0
    accs = []

    for i, (inputs, labels) in enumerate(test_loader):
        inputs, labels = inputs.to(device), labels.to(device)
        outputs = torch.zeros(inputs.shape[0], net.num_classes, num_ens).to(device)
        kl = 0.0

        for j in range(num_ens):
            net_out, _kl = net(inputs)
            kl += _kl
            outputs[:, :, j] = F.log_softmax(net_out, dim=1).data

        log_outputs = utils.logmeanexp(outputs, dim=2)

        beta = metric.get_beta(i - 1, len(test_loader), beta_type, epoch, num_epochs)
        test_loss += criterion(log_outputs, labels, kl, beta)
        accs.append(metric.acc(log_outputs, labels))

    return np.mean(accs)


features_in_hook = []


def hook(module, fea_in, fea_out):
    features_in_hook.append(fea_in[0].data.cpu().numpy())
    return None


def model_hook(net, criterion, train_loader, num_ens=10, beta_type=0.1, epoch=None, num_epochs=None):
    net.eval()
    test_loss = 0.0
    accs = []

    for _ in range(10):
        for i, (inputs, labels) in enumerate(train_loader):
            if i < 10:
                inputs, labels = inputs.to(device), labels.to(device)
                outputs = torch.zeros(inputs.shape[0], net.num_classes, num_ens).to(device)
                kl = 0.0

                for j in range(num_ens):
                    net_out, _kl = net(inputs)
                    kl += _kl
                    outputs[:, :, j] = F.log_softmax(net_out, dim=1).data


def freeze_model(model):
    fc1_mu = np.load(r"part_train/fc1_mu.npy")
    fc1_var = np.load(r"part_train/fc1_var.npy")
    for (name, param) in model.named_parameters():
        print(name)
        if "conv1" in name or "conv2" in name:
            param.requires_grad = False
        else:
            if "sigma" in name:
                print(name)
                s_sigma = np.abs(param.detach().cpu().numpy())
                fc1_rho = np.log(np.exp(np.sqrt(fc1_var * s_sigma * (10 / 4))) - 1)
            elif "quan_wu" in name:
                s_mu = param.detach().cpu().numpy()
                fc1_mu *= s_mu
    # print(fc1_mu.shape, fc1_rho.shape)
    for (name, param) in model.named_parameters():
        if "conv1" in name or "conv2" in name:
            param.requires_grad = False
        else:
            if "W_mu" in name:
                param.data = torch.tensor(fc1_mu.T).float()
            elif "W_rho" in name:
                param.data = torch.tensor(fc1_rho.T).float()


def run(dataset, net_type, seeds):
    layer_type = cfg.layer_type
    activation_type = cfg.activation_type
    priors = cfg.priors

    train_ens = cfg.train_ens
    valid_ens = cfg.valid_ens
    test_ens = cfg.test_ens
    n_epochs = cfg.n_epochs
    lr_start = cfg.lr_start
    num_workers = cfg.num_workers
    valid_size = cfg.valid_size
    batch_size = cfg.batch_size
    beta_type = cfg.beta_type
    use_clt = cfg.use_clt
    clt_num = cfg.clt_num
    quan_scheduler = cfg.quan_scheduler

    train_set, test_set, inputs, outputs = data.get_dataset(dataset)
    train_loader, valid_loader, test_loader = data.get_dataloader(train_set,
                                                                  test_set, valid_size, batch_size, num_workers)

    # if use_clt:
    #     model_path = f"quan_checkpoints/{dataset}/bayesian/quan_model_{net_type}_{layer_type}_{activation_type}_clt_{clt_num}_noise_2.pt"
    # else:
    #     model_path = f"checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}.pt"

    # model_path = f"quan_checkpoints/MNIST/bayesian/quan_model_test_lrt_relu_clt_10_noise_2.pt"
    model_path = f"part_train/quan_model_test_lrt_relu_clt_10_part_trained.pt"

    if net_type == "test":
        model = ModelTest(outputs, inputs, priors, layer_type, activation_type, use_clt, clt_num)
        modules_to_replace = quan.find_modules_to_quantize(model, quan_scheduler)
        model = quan.replace_module_by_names(model, modules_to_replace)
        model.load_state_dict(torch.load(model_path, map_location=torch.device(device)))
    else:
        raise ValueError("Other Network do not supported")

    ckpt_dir = f'quan_checkpoints/{dataset}/bayesian'
    ckpt_name = f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_part_trained.pt'
    ckpt_name_clt = f"part_train/quan_model_{net_type}_{layer_type}_{activation_type}_clt_{10}_part_trained.pt"

    for module in model.children():
        if isinstance(module, layers.FlattenLayer):
            module.register_forward_hook(hook=hook)

    if not os.path.exists(ckpt_dir):
        os.makedirs(ckpt_dir, exist_ok=True)

    freeze_model(model)

    model.to(device)
    criterion = metric.ELBO(len(train_set)).to(device)

    optimizer = Adam(filter(lambda p: p.requires_grad, model.parameters()), lr=lr_start)
    lr_sched = lr_scheduler.ReduceLROnPlateau(optimizer, patience=8, verbose=True)
    valid_loss_max = np.Inf

    if seeds == "time":
        init_seeds(int(time.time()))
    else:
        pass

    t_loss = np.array([])
    t_acc = np.array([])
    v_loss = np.array([])
    v_acc = np.array([])

    # model_hook(model, criterion, train_loader, num_ens=train_ens, beta_type=beta_type, epoch=None,
    #            num_epochs=None)

    # for epoch in range(n_epochs):
    #     train_loss, train_acc, train_kl = train_model(model, optimizer, criterion, train_loader, num_ens=train_ens,
    #                                                   beta_type=beta_type, epoch=epoch, num_epochs=n_epochs)
    #     valid_loss, valid_acc = validate_model(model, criterion, valid_loader, num_ens=valid_ens,
    #                                            beta_type=beta_type, epoch=epoch, num_epochs=n_epochs)
    #     lr_sched.step(valid_loss)
    #
    #     if use_clt:
    #         print("Using central limitation theorem to approximate the Gaussian distribution!")
    #         print("The sample number is {:.4f}".format(10))
    #
    #     print("Epoch: {} \tTraining Loss: {:.4f} \t Training Accuracy: {:.4f} \tValidation Loss: {:.4f} "
    #           "\tValidate Accuracy: {:.4f} \ttrain_kl_div: {:.4f}\n".format(epoch, train_loss, train_acc,
    #                                                                         valid_loss,
    #                                                                         valid_acc, train_kl))
    #
    #     if valid_loss <= valid_loss_max:
    #         print("Validation loss decreased ({:.6f} --> {:.6f}).    Saving model .... \n".format(valid_loss_max,
    #                                                                                               valid_loss))
    #         if use_clt:
    #             best_epoch = epoch
    #             print("The best model trained at epoch {}\n".format(epoch))
    #             torch.save(model.state_dict(), ckpt_name_clt)
    #             valid_loss_max = valid_loss
    #         else:
    #             best_epoch = epoch
    #             print("The best model trained at epoch {}\n".format(epoch))
    #             torch.save(model.state_dict(), ckpt_name)
    #             valid_loss_max = valid_loss
    #
    #     t_acc = np.append(t_acc, train_acc)
    #     t_loss = np.append(t_loss, train_loss)
    #     v_loss = np.append(v_loss, valid_loss)
    #     v_acc = np.append(v_acc, valid_acc)
    # t_loss = np.append(t_loss, best_epoch)
    # if use_clt:
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_clt_{10}'
    #         f'train_loss_part_train.csv', t_loss, delimiter=",")
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_clt_{10}'
    #         f'train_acc_part_train.csv', t_acc, delimiter=",")
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_clt_{10}'
    #         f'valid_loss_part_train.csv', v_loss, delimiter=",")
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_clt_{10}'
    #         f'valid_acc_part_train.csv', v_acc, delimiter=",")
    # else:
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_train_loss_part_train.csv',
    #         t_loss, delimiter=",")
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_train_acc_part_train.csv',
    #         t_acc, delimiter=",")
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_valid_loss_part_train.csv',
    #         v_loss, delimiter=",")
    #     np.savetxt(
    #         f'part_train/quan_model_{net_type}_{layer_type}_{activation_type}_valid_acc_part_train.csv',
    #         v_acc, delimiter=",")

    print("testing...")

    test_acc = model_test(model, criterion, test_loader, num_ens=test_ens, beta_type=beta_type, epoch=None,
                          num_epochs=None)

    print("Test_accuracy: {:.4f} ".format(test_acc))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PyTorch Bayesian Model Training")
    parser.add_argument("--net_type", default="test", type=str, help="model")
    parser.add_argument("--dataset", default="MNIST", type=str, help="dataset=[MNIST/FashionMNIST/CIFAR10"
                                                                     "/CIFAR100]")
    parser.add_argument("--seeds", default="time", type=str, help="random seeds")
    args = parser.parse_args()

    run(args.dataset, args.net_type, args.seeds)
