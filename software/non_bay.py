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
import matplotlib.pyplot as plt
import data as D

import data
import utils
import metric
import config_bayesian as cfg
import time
import random
import torchvision

from tqdm import tqdm

from models.NonBayesianModel.AlexNet import AlexNet
from models.NonBayesianModel.testm import Testm
from models.NonBayesianModel.LeNet import LeNet
from models.NonBayesianModel.test_PCAM import Test_PCAM

import quan

os.environ['CUDA_VISIBLE_DEVICES'] = '0'
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")


def init_seeds(seed):
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)


def get_model(net_type, inputs, outputs):
    if net_type == "lenet":
        return LeNet(outputs, inputs)
    elif net_type == "alexnet":
        return AlexNet(outputs, inputs)
    elif net_type == "test":
        return Testm(outputs, inputs)
    elif net_type == "PCAM":
        return Test_PCAM(outputs, inputs)
    else:
        raise ValueError("Other Network do not supported")


def train_model(net, optimizer, criterion, train_loader):
    net.train()
    training_loss = 0.0
    accs = []
    train_loader = tqdm(train_loader)
    for i, (inputs, labels) in enumerate(train_loader, 1):
        optimizer.zero_grad()

        inputs, labels = inputs.to(device), labels.to(device)

        net_out = net(inputs)

        net.zero_grad()

        loss = criterion(net_out, labels).to(device)
        loss.backward()
        optimizer.step()

        accs.append(metric.acc(F.softmax(net_out.data, dim=1), labels))
        training_loss += loss.cpu().detach().numpy() 

        train_loader.desc = f'Epoch: {epoch:3d}'

    return training_loss / len(train_loader), np.mean(accs)


def validate_model(net, valid_loader, criterion):
    net.train()
    valid_loss = 0.0
    accs = []

    for i, (inputs, labels) in enumerate(valid_loader, 1):
        inputs, labels = inputs.to(device), labels.to(device)

        net_out = net(inputs)

        valid_loss += criterion(net_out, labels).item() 
        accs.append(metric.acc(F.softmax(net_out.data, dim=1), labels))

    return valid_loss / len(valid_loader), np.mean(accs)


def model_test(net, test_loader, criterion):
    net.eval()
    test_loss = 0.0
    accs = []

    for i, (inputs, labels) in enumerate(test_loader, 1):
        inputs, labels = inputs.to(device), labels.to(device)

        net_out = net(inputs)

        test_loss += criterion(net_out, labels)
        accs.append(metric.acc(F.softmax(net_out.data, dim=1), labels))

    return np.mean(accs)


def run(dataset, net_type, seeds):
    # layer_type = cfg.layer_type
    # activation_type = cfg.activation_type
    # priors = cfg.priors

    # train_ens = cfg.train_ens
    # valid_ens = cfg.valid_ens
    # test_ens = cfg.test_ens
    n_epochs = cfg.n_epochs
    lr_start = cfg.lr_start
    num_workers = cfg.num_workers
    valid_size = cfg.valid_size
    batch_size = cfg.batch_size
    # beta_type = cfg.beta_type
    use_clt = cfg.use_clt
    clt_num = cfg.clt_num

    if dataset == "PCAM":
        train_set, val_set, test_set, inputs, outputs = data.get_dataset_pcam()
        train_loader, valid_loader, test_loader = data.get_pcam_dataloader(train_set, val_set, test_set, batch_size,
                                                                           num_workers)
    else:
        train_set, test_set, inputs, outputs = data.get_dataset(dataset)
        train_loader, valid_loader, test_loader = data.get_dataloader(train_set,
                                                                      test_set, valid_size, batch_size, num_workers)

    net = get_model(net_type, inputs, outputs).to(device)

    ckpt_dir = f'checkpoints/{dataset}/non_bayesian'
    ckpt_name = f'checkpoints/{dataset}/non_bayesian/model_{net_type}.pt'

    if not os.path.exists(ckpt_dir):
        os.makedirs(ckpt_dir, exist_ok=True)

    optimizer = Adam(net.parameters(), lr=lr_start)
    lr_sched = lr_scheduler.ReduceLROnPlateau(optimizer, patience=6, verbose=True)
    valid_loss_max = np.Inf
    criterion = torch.nn.CrossEntropyLoss()

    if seeds == "time":
        init_seeds(int(time.time()))
    else:
        raise ValueError("randomness seed only support time!")

    t_loss = np.array([])
    t_acc = np.array([])
    v_loss = np.array([])
    v_acc = np.array([])

    for epoch in range(n_epochs):
        train_loss, train_acc = train_model(net, optimizer, criterion, train_loader)
        valid_loss, valid_acc = validate_model(net, valid_loader, criterion)
        lr_sched.step(valid_loss)

        if use_clt:
            print("Using central limitation theorem to approximate the Gaussian distribution!")
            print("The sample number is {:.4f}".format(clt_num))

        print("Epoch: {} \tTraining Loss: {:.4f} \t Training Accuracy: {:.4f} \tValidation Loss: {:.4f} "
              "\tValidate Accuracy: {:.4f}\n".format(epoch, train_loss, train_acc, valid_loss, valid_acc))

        if valid_loss <= valid_loss_max:
            best_epoch = epoch
            print("Validation loss decreased ({:.6f} --> {:.6f}).    Saving model .... \n".format(valid_loss_max,
                                                                                                  valid_loss))

            print("The best model trained at epoch {}\n".format(epoch))
            torch.save(net.state_dict(), ckpt_name)
            valid_loss_max = valid_loss

        t_acc = np.append(t_acc, train_acc)
        t_loss = np.append(t_loss, train_loss)
        v_loss = np.append(v_loss, valid_loss)
        v_acc = np.append(v_acc, valid_acc)
    t_acc = np.append(t_acc, best_epoch)

    np.savetxt(f'checkpoints/{dataset}/non_bayesian/model_{net_type}_train_loss.csv', t_loss, delimiter=",")
    np.savetxt(f'checkpoints/{dataset}/non_bayesian/model_{net_type}_train_acc.csv', t_acc, delimiter=",")
    np.savetxt(f'checkpoints/{dataset}/non_bayesian/model_{net_type}_valid_loss.csv', v_loss, delimiter=",")
    np.savetxt(f'checkpoints/{dataset}/non_bayesian/model_{net_type}_valid_acc.csv', v_acc, delimiter=",")

    print("testing...")
    test_acc = model_test(net, test_loader, criterion)

    print("Test_accuracy: {:.4f} ".format(test_acc))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PyTorch Bayesian Model Training")
    parser.add_argument("--net_type", default="PCAM", type=str, help="model")
    parser.add_argument("--dataset", default="PCAM", type=str, help="dataset=[MNIST/FashionMNIST/PCAM/CIFAR10"
                                                                    "/CIFAR100]")
    parser.add_argument("--seeds", default="time", type=str, help="random seeds")
    args = parser.parse_args()

    run(args.dataset, args.net_type, args.seeds)
