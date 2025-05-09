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

os.environ['CUDA_VISIBLE_DEVICES'] = '2'
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
            modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            net = quan.replace_module_by_names(net, modules_to_replace)
            return net
        elif net_type == "alexnet":
            return BBBAlexNet(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
        elif net_type == "3conv3fc":
            return BBB3Conv3FC(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
        elif net_type == "test":
            net = ModelTest(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
            modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            net = quan.replace_module_by_names(net, modules_to_replace)
            return net
        elif net_type == "PCAM":
            # net = BayCNN_Pcam(outputs, inputs, priors, layer_type, activation_type, clt, clt_num)
            # modules_to_replace = quan.find_modules_to_quantize(net, quan_scheduler)
            # net = quan.replace_module_by_names(net, modules_to_replace)
            net = Test_PCAM(outputs, inputs)
            return net
        else:
            raise ValueError("Other Bayesian Network do not supported")


def adv_data_gen(model, att_type, data_loader, eps, num_ens, criterion, nb_iter, device):
    # if model.use_clt:
    if True:
        data_path = f"attack_dataset/Bay_clt_10_noise/PCAM/" + att_type
    else:
        data_path = f"attack_dataset/Bay_clt_10_noise/PCAM/" + att_type
    adv_data_transform = torchvision.transforms.ToTensor()
    dataset = D.data.CustomDataset(dataset_path=data_path, att_type=att_type, transfrom=adv_data_transform)
    dataset.attack_dataset_gen(model, data_loader, eps, num_ens, criterion, nb_iter, device)
    return dataset


def adv_test(net, att_type, eps, device, use_baynn, num_ens):
    correct = 0
    adv_examples = []
    data_path = f"attack_dataset/Bay_clt_10_noise/PCAM/{att_type}/nbeps_{eps}_adv_data.json"
    label_path = f"attack_dataset/Bay_clt_10_noise/PCAM/{att_type}/nbeps_{eps}_adv_label.json"
    with open(data_path, "r") as f:
        data = json.load(f)
    with open(label_path, "r") as f:
        label = json.load(f)
    data = torch.tensor(np.array(data, dtype=np.float32).squeeze()).to(device)
    label = torch.tensor(np.array(label).squeeze()).to(device)
    label.to(torch.long)
    data_loader = torch.utils.data.DataLoader(data, 1)
    net.eval()
    pred_label = []
    pred_score = []

    for i, adv_data in enumerate(data_loader):
        if i >= 3000:
            data_path = f"attack_dataset/Bay_clt_10_noise/PCAM/{att_type}/nb_eps_{eps}_pred_label.json"
            with open(data_path, "w") as f:
                json.dump(pred_label, f)

            data_path = f"attack_dataset/Bay_clt_10_noise/PCAM/{att_type}/nb_eps_{eps}_pred_score.json"
            with open(data_path, "w") as f:
                json.dump(pred_score, f)
            break
        if use_baynn:
            outputs = torch.zeros(adv_data.shape[0], net.num_classes, num_ens).to(device)

            for j in range(num_ens):
                net_out, _kl = net(adv_data)
                outputs[:, :, j] = F.log_softmax(net_out, dim=1)

            final_pred = utils.logmeanexp(outputs, dim=2)

            pred_score.append(torch.mean(torch.exp(outputs), dim=2)[:, 1].clone().detach().data.tolist())

            final_pred = final_pred.max(1, keepdim=True)[1]
            pred_label.append(final_pred.clone().detach().data.tolist())

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

            pred_score.append(output.clone().detach().data.tolist())
            pred_label.append(final_pred.clone().detach().data.tolist())

            if final_pred.item() == label[i].item():
                correct += 1

                if eps == 0 and len(adv_examples) < 5:
                    adv_ex = adv_data.squeeze().detach().cpu().numpy()
                    adv_examples.append((label[i].item(), final_pred.item(), adv_ex))
            else:
                if len(adv_examples) < 5:
                    adv_ex = adv_data.squeeze().detach().cpu().numpy()
                    adv_examples.append((label[i].item(), final_pred.item(), adv_ex))

    # print(correct)
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

    train_set, val_set, test_set, inputs, outputs = D.get_dataset_pcam()
    train_loader, valid_loader, test_loader = D.get_pcam_dataloader(train_set, test_set, val_set, batch_size,
                                                               num_workers)

    net = get_model(net_type, inputs, outputs, priors, layer_type, activation_type, use_clt, clt_num, use_bay,
                    quan_scheduler).to(device)
    if use_clt:
        print(use_clt)
        net.load_state_dict(torch.load(fr"checkpoints/{dataset}/non_bayesian/model_PCAM.pt", map_location=device))
        # net.load_state_dict(
        #     torch.load(
        #         fr"quan_checkpoints/{dataset}/bayesian/quan_model_{net_type}_lrt_relu_clt_10_noise_2.pt", map_location="cpu"))
    else:
        net.load_state_dict(torch.load(r"checkpoints/MNIST/bayesian/model_test_lrt_relu.pt", map_location="cpu"))

    net.to(device)
    net.eval()
    # criterion = metric.ELBO(len(test_set)).to(device)
    criterion = torch.nn.CrossEntropyLoss().to(device)

    if seeds == "time":
        init_seeds(int(time.time()))
    else:
        raise ValueError("randomness seed only support time!")


    # epis = np.array([])
    # alea = np.array([])

    # for i, (data, label) in enumerate(test_loader):
    #     print(type(data))
    #     data, label = data.to(device), label.to(device)
    #     data = data.squeeze()
    #     _, eps, ale = utils.get_uncertainty_per_image(net, input, 10)
    #     index = np.argmax(_)
    #     epis = np.append(epis, eps[index])
    #     alea = np.append(alea, ale[index])
    # np.savetxt(f"eps_unc/epistemic_test.csv", epis, delimiter=",")
    # np.savetxt(f"ale_unc/aleatoric_test.csv", alea, delimiter=",")
    # np.savetxt(f"unc/uncer_test.csv", epis+alea, delimiter=",")
            # np.savetxt(f"unc/{att_type}_{eps}_uncer_label_test.csv", uncer_label, delimiter=",")
    #
    # print("useing clt:", net.use_clt, net.clt_num)
    print("generating...")
    for att_type in att_types:
        print(att_type)
        for eps in epsilons:
            print(eps)
            dataset_att = adv_data_gen(net, att_type, test_loader, eps=eps, num_ens=ens, criterion=criterion,
                                       nb_iter=nb_iter, device=device)
            print("finishing", att_type, eps)
    # print("useing clt:", net.use_clt, net.clt_num)
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
    # ckt = "unc/"
    # ckt_ale = "ale_unc/"
    # ckt_eps = "eps_unc/"
    # if not os.path.exists(ckt):
    #     os.makedirs(ckt, exist_ok=True)
    #     os.makedirs(ckt_eps, exist_ok=True)
    #     os.makedirs(ckt_ale, exist_ok=True)
    # for att_type in att_types:
    #     print(att_type)
    #     for eps in epsilons:
    #         print(eps)
    #         epistemic = np.array([])
    #         epistemic_label = np.array([])
    #         aleatoric = np.array([])
    #         aleatoric_label = np.array([])
    #         uncer = np.array([])
    #         uncer_label = np.array([])
    #         data_path = f"attack_dataset/Bay_clt_10/{att_type}/eps_{eps}_adv_data.json"
    #         lable_path = f"attack_dataset/Bay_clt_10/{att_type}/eps_{eps}_adv_label.json"
    #         # unc_rram = np.loadtxt(f"unc/{att_type}_{eps}_uncer.csv", delimiter=",")
    #
    #         with open(data_path, "r") as f:
    #             data = json.load(f)[:1000]
    #         with open(lable_path, "r") as f:
    #             label = json.load(f)[:1000]
    #         data = torch.tensor(np.array(data, dtype=np.float32)).squeeze().to(device)
    #         label = torch.tensor(np.array(label, dtype=np.float32)).squeeze().to(device)
    #         data_new = []
    #         for _ in range(data.shape[0]):
    #             data_new.append((data[_], label[_]))
    #         data_loader = torch.utils.data.DataLoader(data_new, 100)
    #
    #         prediction = np.array([])
    #         for i, (x, y) in enumerate(data_loader):
    #             # op = torch.zeros(x.shape[0], net.num_classes, 10).to(device)
    #             # y = label[i*100:(i+1)*100].cpu().numpy()
    #             _, epi, ale = utils.get_uncertainty_per_batch(net, x.squeeze(), T=10)
    #             pred = torch.max(torch.tensor(_), 1)[1]
    #             prediction = np.append(prediction, pred.data.cpu().numpy() == y.data.cpu().numpy())
    #             for j in range(epi.shape[0]):
    #                 epistemic = np.append(epistemic, epi[j, pred[j]])
    #                 epistemic_label = np.append(epistemic_label, epi[j, int(y[j])])
    #                 aleatoric = np.append(aleatoric, ale[j, pred[j]])
    #                 aleatoric_label = np.append(aleatoric_label, ale[j, int(y[j])])
    #         uncer = np.append(uncer, epistemic+aleatoric)
    #         uncer = np.append(uncer, prediction)
    #         uncer_label = np.append(uncer_label, epistemic_label+aleatoric_label)
    #         aleatoric = np.append(aleatoric, prediction)
    #         epistemic = np.append(epistemic, prediction)
    #         print(prediction.sum() / len(prediction))
    #         print("\n")
    #         res = []
            # for m in range(100):
            #     res.append(np.power(scipy.spatial.distance.jensenshannon(uncer[m, :], unc_rram), 2))
            # print(np.array(res).mean(), np.array(res).std())
            # print(np.power(scipy.spatial.distance.jensenshannon(uncer, unc_rram), 2))
                # if pred != label[i]:
                #     print(ale, epi, ale+epi)
                #     print(pred, label[i])
                #     plt.imshow(x, cmap="gray")
                #     plt.show()
            # np.savetxt(f"eps_unc/{att_type}_{eps}_epistemic_test.csv", epistemic, delimiter=",")
            # np.savetxt(f"ale_unc/{att_type}_{eps}_aleatoric_test.csv", aleatoric, delimiter=",")
            # np.savetxt(f"unc/{att_type}_{eps}_uncer_test.csv", uncer, delimiter=",")
            # np.savetxt(f"unc/{att_type}_{eps}_uncer_label_test.csv", uncer_label, delimiter=",")

    # print("finish")

    # plt.figure(figsize=(5, 5))
    # plt.plot(epsilons, accs, "*-")
    # plt.yticks(np.arange(0, 1.1, step=0.1))
    # plt.xticks(np.arange(0, .35, step=0.05))
    # plt.title("Accuracy vs Epsilon - BayLeNet")
    # plt.xlabel("Epsilon")
    # plt.ylabel("Accuracy")
    # # plt.savefig("Adversarial attack BayLeNet (clt-10) - Accuracy vs Epsilon.png")
    # plt.show()
    #
    # cnt = 0
    # plt.figure(figsize=(10, 10))
    # for i in range(len(epsilons)):
    #     for j in range(len(att_types)):
    #         cnt += 1
    #         data_path = f"attack_dataset/Bay_clt_10/{att_types[j]}/eps_{epsilons[i]}_adv_data.json"
    #         with open(data_path, "r") as f:
    #             data = json.load(f)
    #         ex = np.array(data[10]).squeeze()
    #         plt.subplot(len(epsilons), len(att_types), cnt)
    #         plt.xticks([], [])
    #         plt.yticks([], [])
    #         if j == 0:
    #             plt.ylabel("{}".format(epsilons[i]), fontsize=10)
    #         # orig, adv, ex = examples[i][j]
    #         # plt.title("{} -> {}".format(orig, adv))
    #         plt.imshow(ex, cmap="gray")
    # plt.tight_layout()
    # plt.show()
    # data_in = []
    # rn = np.random.randint(0, 10000, 1)
    # print(rn)
    # for i in range(len(att_types)):
    #     for j in range(len(epsilons)):
    #         data_path = f"attack_dataset/Bay_clt_10_noise/{att_types[i]}/eps_{epsilons[j]}_adv_data.json"
    #         with open(data_path, "r") as f:
    #             data = json.load(f)
    #         data_in.append(np.array(data[rn[0]]).squeeze())
    #
    # for i in range(int(len(epsilons) * len(att_types))):
    #     plt.subplot(len(att_types), len(epsilons), i+1)
    #     plt.imshow(data_in[i].squeeze(), cmap="gray")
    #     plt.axis("off")
    # plt.tight_layout()
    # plt.show()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="PyTorch Adversarial Examples Attacking!")
    parser.add_argument("--net_type", default="PCAM", type=str, help="model")
    parser.add_argument("--dataset", default="PCAM", type=str, help="dataset = [MNIST/FashionMNIST/CIFAR10/CIFAR100]")
    parser.add_argument("--seeds", default="time", type=str, help="random seeds")
    args = parser.parse_args()

    run(args.net_type, args.dataset, args.seeds)
