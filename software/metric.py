import numpy as np
import torch.nn.functional as F
import torch.nn as nn
import torch
from sklearn.metrics import roc_auc_score


class ELBO(nn.Module):
    """docstring for ELBO"""

    def __init__(self, train_size):
        super(ELBO, self).__init__()
        self.train_size = train_size

    def forward(self, inputs, target, kl, beta):
        assert not target.requires_grad
        return F.nll_loss(inputs, target, reduction="mean") * self.train_size + beta * kl


def acc(outputs, targets):
    return np.mean(outputs.cpu().numpy().argmax(axis=1) == targets.data.cpu().numpy())


def PCAM_evaluation_metirc(preds, targets):
    tp = (preds * targets).sum()
    fp = ((1 - targets) * preds).sum()
    fn = (targets * (1 - preds)).sum()
    tn = ((1 - preds) * (1 - targets)).sum()

    eps = 1e-7
    precision = tp / (tp + fp + eps)
    recall = tp / (tp + fn + eps)
    specificity = tn / (fp + tn + eps)

    f1 = 2 * precision * recall / (precision + recall + eps)

    auc_score = roc_auc_score(targets, preds)

    return f1, precision, recall, specificity, auc_score


def calculate_kl(mu_q, sig_q, mu_p, sig_p):
    kl = 0.5 * (2 * torch.log(sig_p / sig_q) - 1 + (sig_q / sig_p).pow(2) + ((mu_p - mu_q) / sig_p).pow(2)).sum()
    if torch.isnan(kl).any():
        print("kl is nan")
    return kl


def get_beta(batch_idx, m, beta_type, epoch, num_epochs):
    if type(beta_type) is float:
        return beta_type

    if beta_type == "Blundell":
        beta = 2 ** (m - (batch_idx + 1)) / (2 ** m - 1)
    elif beta_type == "Soenderby":
        if epoch is None or num_epochs is None:
            raise ValueError("Soenderby method requires both epoch and num_epochs to be passed.")
        beta = min(epoch / (num_epochs // 4), 1)
    elif beta_type == "Standard":
        beta = 1 / m
    else:
        beta = 0
    return beta
