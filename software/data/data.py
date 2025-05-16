import os
import json
import h5py
import numpy as np
import torch
import torchvision
from torch.utils.data import Dataset
import torchvision.transforms as transforms
from torch.utils.data.sampler import SubsetRandomSampler
from adv_attacks.fast_gradient_method import fast_gradient_method
from adv_attacks.projected_gradient_descent import projected_gradient_descent
from adv_attacks.carlini_wagner_l2 import carlini_wagner_l2
from adv_attacks.noise import noise


class Pcam(Dataset):
    def __init__(self, data, label):
        super(Pcam, self).__init__()
        self.data = data
        self.label = label
        self.transform = transforms.Compose(
            [
                transforms.ToTensor(),
                transforms.CenterCrop(32),
                transforms.Resize([18, 18]),
                transforms.Normalize((0.491, 0.482, 0.446), (0.247, 0.243, 0.261))
            ]
        )
        # self.transform = None

    def __len__(self):
        return self.data.shape[0]

    def __getitem__(self, idx):

        image = self.data[idx, :, :, :]
        target = self.label[idx].squeeze()

        if self.transform:
            image = self.transform(image)

        return image, target


def get_dataset_pcam():
    x_hdf5_train = r"data/PCAM/camelyonpatch_level_2_split_train_x.h5/camelyonpatch_level_2_split_train_x.h5"
    y_hdf5_train = r"data/PCAM/camelyonpatch_level_2_split_train_y.h5/camelyonpatch_level_2_split_train_y.h5"
    x_hdf5_val = r"data/PCAM/camelyonpatch_level_2_split_valid_x.h5/camelyonpatch_level_2_split_valid_x.h5"
    y_hdf5_val = r"data/PCAM/camelyonpatch_level_2_split_valid_y.h5/camelyonpatch_level_2_split_valid_y.h5"
    x_hdf5_test = r"data/PCAM/camelyonpatch_level_2_split_test_x.h5/camelyonpatch_level_2_split_test_x.h5"
    y_hdf5_test = r"data/PCAM/camelyonpatch_level_2_split_test_y.h5/camelyonpatch_level_2_split_test_y.h5"
    with h5py.File(x_hdf5_train, "r") as x_train_f:
        x_train = x_train_f["x"][:]
    with h5py.File(y_hdf5_train, "r") as y_train_f:
        y_train = y_train_f["y"][:]
    with h5py.File(x_hdf5_val, "r") as x_val_f:
        x_valid = x_val_f["x"][:]
    with h5py.File(y_hdf5_val, "r") as y_val_f:
        y_valid = y_val_f["y"][:]
    with h5py.File(x_hdf5_test, "r") as x_test_f:
        x_test = x_test_f["x"][:]
    with h5py.File(y_hdf5_test, "r") as y_test_f:
        y_test = y_test_f["y"][:]

    train_set = Pcam(x_train, y_train)
    test_set = Pcam(x_test, y_test)
    val_set = Pcam(x_valid, y_valid)

    inputs = 3
    num_classes = 2

    return train_set, val_set, test_set, inputs, num_classes


def get_pcam_dataloader(train_set, test_set, valid_set, batch_size, num_workers):
    train_loader = torch.utils.data.DataLoader(train_set,
                                               batch_size=batch_size,
                                               shuffle=True,
                                               drop_last=False,
                                               num_workers=num_workers)
    valid_loader = torch.utils.data.DataLoader(valid_set,
                                               batch_size=batch_size,
                                               shuffle=False,
                                               drop_last=False,
                                               num_workers=num_workers)
    test_loader = torch.utils.data.DataLoader(test_set,
                                              batch_size=batch_size,
                                              shuffle=False,
                                              drop_last=False,
                                              num_workers=num_workers)

    return train_loader, valid_loader, test_loader


class CustomDataset(Dataset):
    """docstring for CustomDataset"""

    def __init__(self, dataset_path, att_type, transfrom=None):
        super(CustomDataset, self).__init__()
        self.adv_label_path = None
        self.adv_data_path = None
        self.dataset_path = dataset_path
        self.att_type = att_type
        self.transfrom = transfrom
        if not os.path.exists(dataset_path):
            os.makedirs(dataset_path, exist_ok=True)

    def attack_dataset_gen(self, model, data_loader, eps, num_ens, criterion, nb_iter, device):

        model.eval()
        adv_data = []
        adv_label = []

        self.adv_data_path = self.dataset_path + "/" + f"eps_{eps}_adv_data.json"
        self.adv_label_path = self.dataset_path + "/" + f"eps_{eps}_adv_label.json"

        if self.att_type == "fgsm":
            for i, (data, label) in enumerate(data_loader):
                data, label = data.to(device), label.to(device)
                adv_x = fast_gradient_method(model, data, eps=eps, norm=np.inf, num_ens=num_ens, criterion=criterion,
                                             y=label, clip_max=1, clip_min=0)
                adv_data.append(adv_x.tolist())
                adv_label.append(label.tolist())

            with open(self.adv_data_path, "w") as file_obj:
                json.dump(adv_data, file_obj)
            with open(self.adv_label_path, "w") as file_obj:
                json.dump(adv_label, file_obj)
        elif self.att_type == "bim":
            for i, (data, label) in enumerate(data_loader):
                data, label = data.to(device), label.to(device)
                adv_x = projected_gradient_descent(model, data, eps=eps, norm=np.inf, nb_iter=eps, num_ens=num_ens,
                                                   criterion=criterion, eps_iter=eps, y=label, clip_max=1,
                                                   clip_min=0, rand_init=False)
                adv_data.append(adv_x.tolist())
                adv_label.append(label.tolist())
            with open(self.adv_data_path, "w") as file_obj:
                json.dump(adv_data, file_obj)
            with open(self.adv_label_path, "w") as file_obj:
                json.dump(adv_label, file_obj)
        elif self.att_type == "pgd":
            for i, (data, label) in enumerate(data_loader):
                data, label = data.to(device), label.to(device)
                adv_x = projected_gradient_descent(model, data, eps=eps, norm=np.inf, nb_iter=eps, num_ens=num_ens,
                                                   criterion=criterion, eps_iter=eps, y=label, clip_max=1,
                                                   clip_min=0, rand_init=True)
                adv_data.append(adv_x.tolist())
                adv_label.append(label.tolist())
            with open(self.adv_data_path, "w") as file_obj:
                json.dump(adv_data, file_obj)
            with open(self.adv_label_path, "w") as file_obj:
                json.dump(adv_label, file_obj)
        elif self.att_type == "cw":
            for i, (data, label) in enumerate(data_loader):
                data, label = data.to(device), label.to(device)
                adv_x = carlini_wagner_l2(model, data, n_classes=10, num_ens=num_ens, y=label)
                adv_data.append(adv_x.tolist())
                adv_label.append(label.tolist())
            with open(self.adv_data_path, "w") as file_obj:
                json.dump(adv_data, file_obj)
            with open(self.adv_label_path, "w") as file_obj:
                json.dump(adv_label, file_obj)
        elif self.att_type == "noise":
            for i, (data, label) in enumerate(data_loader):
                data, label = data.to(device), label.to(device)
                adv_x = noise(data, eps=eps, norm=np.inf, clip_min=0, clip_max=1)
                adv_data.append(adv_x.tolist())
                adv_label.append(label.tolist())
            with open(self.adv_data_path, "w") as file_obj:
                json.dump(adv_data, file_obj)
            with open(self.adv_label_path, "w") as file_obj:
                json.dump(adv_label, file_obj)
        else:
            raise NotImplementedError("Only support noise, fgsm, BIM , pgd and C&W attack!")

    def attack_dataset_load(self):
        assert self.adv_data_path is not None
        assert self.adv_label_path is not None
        with open(self.adv_data_path, "r") as file_obj:
            adv_data = json.load(file_obj)
        with open(self.adv_label_path, "r") as file_obj:
            adv_label = json.load(file_obj)
        if self.transfrom:
            adv_data = self.transfrom(adv_data)
            adv_label = self.transfrom(adv_label)
        return adv_data, adv_label

    def __len__(self):
        assert self.adv_label_path is not None
        with open(self.adv_label_path, "r") as file_obj:
            labels = json.load(file_obj)
            if len(labels) == 0:
                raise Exception("Dataset is empty! You must call attack_dataset_gen method first to generate the "
                                "adversarial dataset!")
            else:
                return len(labels)

    def __getitem__(self, idx, bs=None):
        assert self.adv_data_path is not None
        with open(self.adv_data_path, "r") as file_obj:
            data = json.load(file_obj)
            if len(data) == 0:
                raise Exception("Dataset is empty! You must call attack_dataset_gen method first to generate the "
                                "adversarial dataset!")
            else:
                sample = data[idx]
                if self.transfrom:
                    sample = self.transfrom(sample)
        assert self.adv_data_path is not None
        with open(self.adv_label_path, "r") as file_obj:
            labels = json.load(file_obj)
            if len(labels) == 0:
                raise Exception("Dataset is empty! You must call attack_dataset_gen method first to generate the "
                                "adversarial dataset!")
            else:
                label = labels[idx]
                if self.transfrom:
                    sample = self.transfrom(sample)
        return sample, label


def extract_classes(dataset, classes):
    idx = torch.zeros_like(dataset.targets, dtype=torch.bool)
    for target in classes:
        idx = idx | (dataset.targets == target)

    data, targets = dataset.data[idx], dataset.targets[idx]
    return data, targets


def get_dataset(dataset):
    transform_mnist = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0,), (1,)),
        transforms.Resize((32, 32))])

    transform_fashion_mnist = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0,), (1,)),
        transforms.Resize((32, 32))])

    transform_cifar = transforms.Compose([
        transforms.Resize((32, 32)),
        transforms.ToTensor(),
        transforms.Normalize((0.491, 0.482, 0.446), (0.247, 0.243, 0.261)),
        transforms.RandomHorizontalFlip()])

    if dataset == "MNIST":
        train_set = torchvision.datasets.MNIST(root="./data",
                                               train=True,
                                               download=True,
                                               transform=transform_mnist)
        test_set = torchvision.datasets.MNIST(root="./data",
                                              train=False,
                                              download=True,
                                              transform=transform_mnist)
        num_classes = 10
        inputs = 1
    elif dataset == "FashionMNIST":
        train_set = torchvision.datasets.FashionMNIST(root="./data",
                                                      train=True,
                                                      download=True,
                                                      transform=transform_fashion_mnist)
        test_set = torchvision.datasets.FashionMNIST(root="./data",
                                                     train=False,
                                                     download=True,
                                                     transform=transform_fashion_mnist)
        num_classes = 10
        inputs = 1
    elif dataset == "CIFAR10":
        train_set = torchvision.datasets.CIFAR10(root="./data",
                                                 train=True,
                                                 download=True,
                                                 transform=transform_cifar)
        test_set = torchvision.datasets.CIFAR10(root="./data",
                                                train=False,
                                                download=True,
                                                transform=transform_cifar)
        num_classes = 10
        inputs = 3
    elif dataset == "CIFAR100":
        train_set = torchvision.datasets.CIFAR100(root="./data",
                                                  train=True,
                                                  download=True,
                                                  transform=transform_cifar)
        test_set = torchvision.datasets.CIFAR100(root="./data",
                                                 train=False,
                                                 download=True,
                                                 transform=transform_cifar)
        num_classes = 100
        inputs = 3

    return train_set, test_set, inputs, num_classes


def get_dataloader(train_set, test_set, valid_size, batch_size, num_workers):
    num_train = len(train_set)
    indices = list(range(num_train))
    np.random.shuffle(indices)
    split = int(np.floor(valid_size * num_train))
    train_idx, valid_idx = indices[split:], indices[:split]

    train_sampler = SubsetRandomSampler(train_idx)
    valid_sampler = SubsetRandomSampler(valid_idx)

    train_loader = torch.utils.data.DataLoader(train_set,
                                               batch_size=batch_size,
                                               sampler=train_sampler,
                                               num_workers=num_workers)
    valid_loader = torch.utils.data.DataLoader(train_set,
                                               batch_size=batch_size,
                                               sampler=valid_sampler,
                                               num_workers=num_workers)
    test_loader = torch.utils.data.DataLoader(test_set,
                                              batch_size=batch_size,
                                              num_workers=num_workers)

    return train_loader, valid_loader, test_loader


if __name__ == "__main__":
    train_set, val_set, test_set, inputs, num_classes = get_dataset_pcam()
    train_loader, valid_loader, test_loader = get_pcam_dataloader(train_set, test_set, val_set, 128, 0)
    for i, (x, y) in enumerate(train_loader):
        print(x.shape, y.shape, x.max())