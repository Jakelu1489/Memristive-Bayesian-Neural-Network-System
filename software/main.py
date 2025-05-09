# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.


# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

from __future__ import print_function

import os
import argparse

import torch
import numpy as np
from torch.optim import Adam, lr_scheduler, SGD
from torch.nn import functional as F

import data
import utils
import metric
import config_bayesian as cfg
import time
import random

from tqdm import tqdm

from models.BayesianModel.Bay3Conv3FC import BBB3Conv3FC
from models.BayesianModel.BayAlexNet import BBBAlexNet
from models.BayesianModel.BayLeNet import BBBLeNet
from models.BayesianModel.BayCNN import ModelTest

os.environ['CUDA_VISIBLE_DEVICES'] = '2'
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

def init_seeds(seed):
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)


def get_model(net_type, inputs, outputs, priors, layer_type, activation_type, clt, clt_num):
    if net_type == "lenet":
        return BBBLeNet(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
    elif net_type == "alexnet":
        return BBBAlexNet(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
    elif net_type == "3conv3fc":
        return BBB3Conv3FC(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
    elif net_type == "test":
        return ModelTest(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
    else:
        raise ValueError("Other Network do not supported")


def train_model(net, optimizer, criterion, train_loader, num_ens=1, beta_type=0.1, epoch=None, num_epochs=None):
    net.train()
    training_loss = 0.0
    accs = []
    kl_list = []
    train_loader = tqdm(train_loader)
    for i, (inputs, labels) in enumerate(train_loader, 1):

        optimizer.zero_grad()

        inputs, labels = inputs.to(device), labels.to(device)
        outputs = torch.zeros(inputs.shape[0], net.num_classes, num_ens).to(device)

        kl = 0.0

        for j in range(num_ens):
            net_out, _kl = net(inputs)
            kl += _kl
            outputs[:, :, j] = F.log_softmax(net_out, dim=1)

        kl /= num_ens
        kl_list.append(kl.item())
        log_outputs = utils.logmeanexp(outputs, dim=2)

        beta = metric.get_beta(i - 1, len(train_loader), beta_type, epoch, num_epochs)
        loss = criterion(log_outputs, labels, kl, beta)
        loss.backward()
        optimizer.step()

        accs.append(metric.acc(log_outputs.data, labels))
        training_loss += loss.cpu().detach().numpy()  # * inputs.size(0)

        train_loader.desc = f'Epoch: {epoch:3d}'

    return training_loss / len(train_loader), np.mean(accs), np.mean(kl_list)


def validate_model(net, criterion, valid_loader, num_ens=1, beta_type=0.1, epoch=None, num_epochs=None):
    net.train()
    valid_loss = 0.0
    accs = []

    for i, (inputs, labels) in enumerate(valid_loader):
        inputs, labels = inputs.to(device), labels.to(device)
        outputs = torch.zeros(inputs.shape[0], net.num_classes, num_ens).to(device)
        kl = 0.0

        for j in range(num_ens):
            net_out, _kl = net(inputs)
            kl += _kl
            outputs[:, :, j] = F.log_softmax(net_out, dim=1).data

        log_outputs = utils.logmeanexp(outputs, dim=2)

        beta = metric.get_beta(i - 1, len(valid_loader), beta_type, epoch, num_epochs)
        valid_loss += criterion(log_outputs, labels, kl, beta).item()  # * inputs.size(0)
        accs.append(metric.acc(log_outputs, labels))

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

    train_set, test_set, inputs, outputs = data.get_dataset(dataset)
    train_loader, valid_loader, test_loader = data.get_dataloader(train_set,
                                                                  test_set, valid_size, batch_size, num_workers)

    net = get_model(net_type, inputs, outputs, priors, layer_type, activation_type, use_clt, clt_num).to(device)

    ckpt_dir = f'checkpoints/{dataset}/bayesian'
    ckpt_name = f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}.pt'
    ckpt_name_clt = f"checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_clt_{clt_num}.pt"
    # net.load_state_dict(torch.load(r"checkpoints/MNIST/bayesian/model_test_lrt_relu_clt_10", map_location="cpu"))

    if not os.path.exists(ckpt_dir):
        os.makedirs(ckpt_dir, exist_ok=True)

    criterion = metric.ELBO(len(train_set)).to(device)
    optimizer = Adam(net.parameters(), lr=lr_start)
    lr_sched = lr_scheduler.ReduceLROnPlateau(optimizer, patience=6, verbose=True)
    valid_loss_max = np.Inf
    net.to(device)

    if seeds == "time":
        init_seeds(int(time.time()))
    else:
        raise ValueError("randomness seed only support time!")

    t_loss = np.array([])
    t_acc = np.array([])
    v_loss = np.array([])
    v_acc = np.array([])

    for epoch in range(n_epochs):
        train_loss, train_acc, train_kl = train_model(net, optimizer, criterion, train_loader, num_ens=train_ens,
                                                      beta_type=beta_type, epoch=epoch, num_epochs=n_epochs)
        valid_loss, valid_acc = validate_model(net, criterion, valid_loader, num_ens=valid_ens, beta_type=beta_type,
                                               epoch=epoch, num_epochs=n_epochs)
        lr_sched.step(valid_loss)

        if use_clt:
            print("Using central limitation theorem to approximate the Gaussian distribution!")
            print("The sample number is {:.4f}".format(clt_num))

        print("Epoch: {} \tTraining Loss: {:.4f} \t Training Accuracy: {:.4f} \tValidation Loss: {:.4f} "
              "\tValidate Accuracy: {:.4f} \ttrain_kl_div: {:.4f}\n".format(epoch, train_loss, train_acc,
                                                                            valid_loss,
                                                                            valid_acc, train_kl))

        if valid_loss <= valid_loss_max:
            best_epoch = epoch
            print("Validation loss decreased ({:.6f} --> {:.6f}).    Saving model .... \n".format(valid_loss_max,
                                                                                                  valid_loss))
            if use_clt:
                print("The best model trained at epoch {}\n".format(epoch))
                torch.save(net.state_dict(), ckpt_name_clt)
                valid_loss_max = valid_loss
            else:
                print("The best model trained at epoch {}\n".format(epoch))
                torch.save(net.state_dict(), ckpt_name)
                valid_loss_max = valid_loss

        t_acc = np.append(t_acc, train_acc)
        t_loss = np.append(t_loss, train_loss)
        v_loss = np.append(v_loss, valid_loss)
        v_acc = np.append(v_acc, valid_acc)
    t_acc = np.append(t_acc, best_epoch)
    if use_clt:
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_clt_{clt_num}_'
                   f'train_loss.csv', t_loss, delimiter=",")
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_clt_{clt_num}_'
                   f'train_acc.csv', t_acc, delimiter=",")
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_clt_{clt_num}_'
                   f'valid_loss.csv', v_loss, delimiter=",")
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_clt_{clt_num}_'
                   f'valid_acc.csv', v_acc, delimiter=",")
    else:
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_train_loss.csv',
                   t_loss, delimiter=",")
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_train_acc.csv',
                   t_acc, delimiter=",")
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_valid_loss.csv',
                   v_loss, delimiter=",")
        np.savetxt(f'checkpoints/{dataset}/bayesian/model_{net_type}_{layer_type}_{activation_type}_valid_acc.csv',
                   v_acc, delimiter=",")

    print("testing...")
    test_acc = model_test(net, criterion, test_loader, num_ens=test_ens, beta_type=beta_type, epoch=None,
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
