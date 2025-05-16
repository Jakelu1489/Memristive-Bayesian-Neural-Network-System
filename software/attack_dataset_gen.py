import scipy.spatial.distance

import data as D
import torch
import torch.nn.functional as F
import matplotlib.pyplot as plt
import numpy as np
import argparse
import os

import torchvision.transforms

import config_adv as cfg
import utils
import metric
import random
import time

from models.BayesianModel.Bay3Conv3FC import BBB3Conv3FC
from models.BayesianModel.BayAlexNet import BBBAlexNet
from models.BayesianModel.BayLeNet import BBBLeNet
from models.BayesianModel.BayCNN import ModelTest
from models.NonBayesianModel.testm import Testm
from models.BayesianModel.BayCNN_Pcam import BayCNN_Pcam
from models.NonBayesianModel.test_PCAM import Test_PCAM

import quan
import json

os.environ['CUDA_VISIBLE_DEVICES'] = '0'
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")


def init_seeds(seed):
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)


def get_model(net_type, inputs, outputs, priors, layer_type, activation_type, clt, clt_num, use_bay, quan_scheduler):
    if use_bay:
        if net_type == "lenet":
            net = BBBLeNet(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
            # if quantized
            # modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            # net = quan.replace_module_by_names(net, modules_to_replace)
            return net
        elif net_type == "alexnet":
            net = BBBAlexNet(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
            # if quantized
            # modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            # net = quan.replace_module_by_names(net, modules_to_replace)
            return net
        elif net_type == "3conv3fc":
            net = BBB3Conv3FC(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
            # if quantized
            # modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            # net = quan.replace_module_by_names(net, modules_to_replace)
            return net
        elif net_type == "test":
            net = ModelTest(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
            modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            net = quan.replace_module_by_names(net, modules_to_replace)
            return net
        elif net_type == "PCAM":
            net = BayCNN_Pcam(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
            modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            net = quan.replace_module_by_names(net, modules_to_replace)
            return net
        else:
            raise ValueError("Other Bayesian Network do not supported")
    else:
        if net_type == "test":
            net = Testm(outputs, inputs)
            return net
        elif net_type == "PCAM":
            net = Test_PCAM(outputs, inputs)
            return net
        else:
            raise ValueError("Other Network do not supported")


def adv_data_gen(model, att_type, data_loader, eps, num_ens, criterion, nb_iter, dataset, use_baynn, device):

    if use_baynn:
        data_path = f"attack_dataset/Bay_clt_10_noise/{dataset}/" + att_type
    else:
        data_path = f"attack_dataset/Non_Bay/{dataset}/" + att_type
    adv_data_transform = torchvision.transforms.ToTensor()
    dataset = D.data.CustomDataset(dataset_path=data_path, att_type=att_type, transfrom=adv_data_transform)
    dataset.attack_dataset_gen(model, data_loader, eps, num_ens, criterion, nb_iter, device)
    return dataset


def adv_test(net, att_type, eps, device, use_baynn, dataset, num_ens):
    correct = 0
    adv_examples = []
    if use_baynn:
        data_path = f"attack_dataset/Bay_clt_10_noise/{dataset}/{att_type}/eps_{eps}_adv_data.json"
        label_path = f"attack_dataset/Bay_clt_10_noise/{dataset}/{att_type}/eps_{eps}_adv_label.json"
    else:
        data_path = f"attack_dataset/Non_Bay/{dataset}/{att_type}/eps_{eps}_adv_data.json"
        label_path = f"attack_dataset/Non_Bay/{dataset}/{att_type}/eps_{eps}_adv_label.json"
    with open(data_path, "r") as f:
        data = json.load(f)
    with open(label_path, "r") as f:
        label = json.load(f)
    data = torch.tensor(np.array(data, dtype=np.float32).squeeze()).to(device)
    label = torch.tensor(np.array(label).squeeze()).to(device)
    label.to(torch.long)
    data_loader = torch.utils.data.DataLoader(data, 1)
    net.eval()

    for i, adv_data in enumerate(data_loader):
        if use_baynn:
            outputs = torch.zeros(adv_data.shape[0], net.num_classes, num_ens).to(device)

            for j in range(num_ens):
                net_out, _kl = net(adv_data)
                outputs[:, :, j] = F.log_softmax(net_out, dim=1)

            final_ = utils.logmeanexp(outputs, dim=2)

            final_pred = final_.max(1, keepdim=True)[1]

            if final_pred.data == label[i]:
                correct += 1

                if eps == 0 and len(adv_examples) < 5:
                    adv_ex = adv_data.squeeze().detach().cpu().numpy()
                    adv_examples.append((label[i], final_pred.item(), adv_ex))
            else:
                if len(adv_examples) < 5:
                    adv_ex = adv_data.squeeze().detach().cpu().numpy()
                    adv_examples.append((label[i], final_pred.item(), adv_ex))
        else:
            output = F.softmax(net(adv_data), dim=1)

            final_pred = output.max(1, keepdim=True)[1]

            if final_pred.item() == label[i].item():
                correct += 1

                if eps == 0 and len(adv_examples) < 5:
                    adv_ex = adv_data.squeeze().detach().cpu().numpy()
                    adv_examples.append((label[i].item(), final_pred.item(), adv_ex))
            else:
                if len(adv_examples) < 5:
                    adv_ex = adv_data.squeeze().detach().cpu().numpy()
                    adv_examples.append((label[i].item(), final_pred.item(), adv_ex))

    final_acc = correct / float(i)
    print("Epsilon: {} \t Test accuracy = {} / {} = {}".format(eps, correct, i, final_acc))

    return final_acc, adv_examples


def run(net_type, dataset, seeds):
    batch_size = cfg.batch_size
    num_workers = cfg.num_workers
    use_bay = cfg.use_BayNN
    use_clt = cfg.use_clt
    clt_num = cfg.clt_num
    priors = cfg.priors
    layer_type = cfg.layer_type
    activation_type = cfg.activation_type
    ens = cfg.ens
    nb_iter = cfg.nb_iter
    att_types = cfg.att_type
    epsilons = cfg.eps
    test_ens = cfg.test_ens
    quan_scheduler = cfg.quan_scheduler

    accs = []
    # examples = []

    if dataset == "PCAM":
        train_set, val_set, test_set, inputs, outputs = D.get_dataset_pcam()
        train_loader, valid_loader, test_loader = D.get_pcam_dataloader(train_set, test_set, val_set, batch_size,
                                                               num_workers)
    else:
        train_set, test_set, inputs, outputs = D.get_dataset(dataset)
        train_loader, valid_loader, test_loader = D.get_dataloader(train_set,
                                                                      test_set, valid_size, batch_size, num_workers)


    net = get_model(net_type, inputs, outputs, priors, layer_type, activation_type, use_clt, clt_num, use_bay,
                    quan_scheduler).to(device)
    if use_bay:
        net.load_state_dict(torch.load(f"quan_checkpoints/{dataset}/bayesian/quan_model_{net_type}_lrt_relu_clt_10.pt", map_location=device))
    else:
        net.load_state_dict(torch.load(f"checkpoints/{dataset}/non_bayesian/model_{net_type}.pt", map_location=device))

    net.to(device)
    net.eval()
    if use_bay:
        criterion = metric.ELBO(len(test_set)).to(device)
    else:
        criterion = torch.nn.CrossEntropyLoss().to(device)

    if seeds == "time":
        init_seeds(int(time.time()))
    else:
        raise ValueError("randomness seed only support time!")

    # if use_bay:
    #     print("useing clt:", net.use_clt, net.clt_num)
    
    # print("generating...")
    # for att_type in att_types:
    #     print(att_type)
    #     for eps in epsilons:
    #         print(eps)
    #         dataset_att = adv_data_gen(net, att_type, test_loader, eps=eps, num_ens=ens, criterion=criterion,
    #                                    nb_iter=nb_iter, use_baynn=use_bay, device=device)
    #         print("finishing", att_type, eps)

    # if use_bay:
    #     print("useing clt:", net.use_clt, net.clt_num)
    # print("testing...")
    # for att_type in att_types:
    #     print(att_type)
    #     for eps in epsilons:
    #         print(eps)
    #         acc, adv_examples = adv_test(net, att_type, eps, device, use_baynn=False, num_ens=ens)
    #         accs.append(acc)
    #         # examples.append(adv_examples)
    # print("finish", accs)
    # accs = np.array(accs).reshape(-1, len(epsilons))
    # print(accs)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PyTorch Adversarial Examples Attacking!")
    parser.add_argument("--net_type", default="MNIST", type=str, help="model")
    parser.add_argument("--dataset", default="MNIST", type=str, help="dataset = [MNIST/PCAM]")
    parser.add_argument("--seeds", default="time", type=str, help="random seeds")
    args = parser.parse_args()

    run(args.net_type, args.dataset, args.seeds)
