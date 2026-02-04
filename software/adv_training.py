import argparse
import os
import random
import time
import math
from typing import Tuple, Optional

import torch
import torch.nn as nn
import torch.nn.functional as F
from torch import special as tspecial
from contextlib import nullcontext

import scipy.stats as sps
import numpy as np

import metric
from models.NonBayesianModel.testm import Testm
from models.BayesianModel.BayCNN import ModelTest
from data.data import get_dataset, get_dataloader

os.environ["CUDA_VISIBLE_DEVICES"] = "2"
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")


def set_seed(seed: int = 123456):
    if type(seed) is str:
        seed = int(time.time())
    random.seed(seed)
    np.random.seed(seed)
    torch.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    torch.backends.cudnn.deterministic = False
    torch.backends.cudnn.benchmark = True


def get_model(net_type, inputs, outputs):
    if net_type == "test":
        return Testm(outputs, inputs)
    elif net_type == "test_bnn":
        return ModelTest(outputs, inputs, priors=None, layer_type="lrt", activation_type="relu", clt=True, clt_num=10)
    else:
        raise ValueError("Other Network do not supported")


def build_cnn_from_bnn(bnn_ckpt_path: str, inputs: int, num_classes: int) -> nn.Module:
    bayes_model = get_model("test_bnn", inputs, num_classes).to(device)
    bayes_model.load_state_dict(torch.load(bnn_ckpt_path, map_location=device))

    bayes_sd = bayes_model.state_dict()

    cnn_model = get_model("test", inputs, num_classes).to(device)
    cnn_model_sd = cnn_model.state_dict()

    new_sd = {}

    for k in cnn_model_sd.keys():

        base_k = k
        cand_keys = []

        if base_k.endswith(".weight"):
            prefix = base_k[:-len(".weight")]
            cand_keys += [
                prefix + ".weight_mu",
                prefix + ".mu",
                prefix + ".W_mu",
            ]
        elif base_k.endswith(".bias"):
            prefix = base_k[:-len(".bias")]
            cand_keys += [
                prefix + ".bias_mu",
                prefix + ".mu_bias",
            ]

        found = False
        for ck in cand_keys:
            if ck in bayes_sd and bayes_sd[ck].shape == cnn_model_sd[k].shape:
                new_sd[k] = bayes_sd[ck]
                found = True
                break

        if not found:
            new_sd[k] = cnn_model_sd[k]
            print(f"[MeanCNN] WARN: no Bayes param mapped to {k}, keep CNN init.")

    cnn_model.load_state_dict(new_sd)
    return cnn_model


def _forward(model, x: torch.Tensor, mc_sample: int = 1):
    if mc_sample <= 1:
        logits = model(x)
        return logits

    # out = torch.zeros(x.shape[0], 10, mc_sample).to(device)
    logps = []
    kl = 0.0
    for i in range(mc_sample):
        net_out, _kl = model(x)
        kl += _kl
        # out[:, :, i] = F.softmax(net_out, dim=1)
        logps.append(F.log_softmax(net_out, dim=1))
    kl /= mc_sample
    logps = torch.stack(logps, dim=0)
    out = torch.logsumexp(logps, dim=0) - math.log(mc_sample)

    return out, kl


# -----------------------------
# PGD Attack (used by PGD-AT/TRADES/MART/GradAlign eval & gen)
# -----------------------------
@torch.no_grad()
def _clamp_linf(x_adv, x_nat, eps):
    return (x_adv - x_nat).clamp(-eps, eps) + x_nat


def pgd_linf(model, x, y, criterion, eps, alpha, steps, random_start: bool = True, use_amp: bool = False,
             model_type: str = "test", mc_sample: int = 1, kl_weight: float = 0.1) -> torch.Tensor:
    x_nat = x.detach()
    if random_start:
        x_adv = x_nat + torch.empty_like(x_nat).uniform_(-eps, eps)
        x_adv = x_adv.clamp(0.0, 1.0)
    else:
        x_adv = x_nat.clone()

    scaler_ctx = torch.cuda.amp.autocast if (use_amp and torch.cuda.is_available()) else torch.cpu.amp.autocast
    for _ in range(steps):
        x_adv.requires_grad_(True)
        with nullcontext():
            if model_type == "test":
                logits = _forward(model, x_adv, mc_sample)
                loss = criterion(logits, y)
            elif model_type == "test_bnn":
                logits, kl = _forward(model, x_adv, mc_sample)
                loss = F.nll_loss(logits, y)
        grad = torch.autograd.grad(loss, x_adv)[0]
        x_adv = x_adv.detach() + alpha * torch.sign(grad.detach())
        x_adv = _clamp_linf(x_adv, x_nat, eps)
        x_adv = x_adv.clamp(0.0, 1.0)
    return x_adv.detach()


# -----------------------------
# TRADES / MART / GradAlign losses
# -----------------------------

def trades_adv(model, x, eps, alpha, steps, use_amp: bool = False, model_type: str = "test",
               mc_sample: int = 1) -> torch.Tensor:
    x_nat = x.detach()
    x_adv = x_nat + 0.001 * torch.randn_like(x_nat)
    x_adv = x_adv.clamp(0.0, 1.0)
    scaler_ctx = torch.cuda.amp.autocast if (use_amp and torch.cuda.is_available()) else torch.cpu.amp.autocast
    for _ in range(steps):
        x_adv.requires_grad_(True)
        with nullcontext():
            if model_type == "test":
                with torch.no_grad():
                    logits_nat = _forward(model, x_nat, mc_sample)
                logits_adv = model(x_adv)
                loss_kl = F.kl_div(F.log_softmax(logits_adv, dim=1), F.softmax(logits_nat, dim=1),
                                   reduction='batchmean')
            elif model_type == "test_bnn":
                with torch.no_grad():
                    logits_nat, _ = _forward(model, x_nat, mc_sample)
                logits_adv, _ = _forward(model, x_adv, mc_sample)
                loss_kl = F.kl_div(logits_adv, torch.exp(logits_nat), reduction='batchmean')
        grad = torch.autograd.grad(loss_kl, x_adv)[0]
        x_adv = x_adv.detach() + alpha * torch.sign(grad.detach())
        x_adv = _clamp_linf(x_adv, x_nat, eps)
        x_adv = x_adv.clamp(0.0, 1.0)

    return x_adv.detach()


def mart_adv(model, x, y, criterion, eps, alpha, steps, use_amp: bool = False,
             model_type: str = "test", mc_sample: int = 1, kl_weight: float = 0.1):
    return pgd_linf(model, x, y, criterion, eps, alpha, steps, random_start=True, use_amp=use_amp,
                    model_type=model_type,
                    mc_sample=mc_sample, kl_weight=kl_weight)


def loss_pgd_at(model, x, y, criterion, eps, alpha, steps, use_amp: bool = False,
                model_type: str = "test", mc_sample: int = 1, kl_weight: float = 0.1):
    x_adv = pgd_linf(model, x, y, criterion, eps, alpha, steps, random_start=True, use_amp=use_amp,
                     model_type=model_type, mc_sample=mc_sample, kl_weight=kl_weight)

    if model_type == "test":
        logits_adv = _forward(model, x_adv, mc_sample)
        loss = criterion(logits_adv, y)
        return loss, {"adv_ce": loss.item()}
    elif model_type == "test_bnn":
        logits_adv, kl = _forward(model, x_adv, mc_sample)
        loss = criterion(logits_adv, y, kl, kl_weight)
        return loss, {"adv_ce": loss.item()}


def loss_trades(model, x, y, criterion, eps, alpha, steps, beta, amp, model_type: str = "test", mc_sample: int = 1,
                kl_weight: float = 0.1):
    x_adv = trades_adv(model, x, eps, alpha, steps, amp, model_type, mc_sample)

    if model_type == "test":
        logits_nat = model(x)
        logits_adv = model(x_adv)
        ce_clean = criterion(logits_nat, y)
        kl = F.kl_div(F.log_softmax(logits_adv, dim=1), F.softmax(logits_nat, dim=1), reduction='batchmean')
        loss = ce_clean + beta * kl

        return loss, {"clean_ce": ce_clean.item(), "kl": kl.item()}
    elif model_type == "test_bnn":
        logits_nat, kl_nat = _forward(model, x, mc_sample)
        logits_adv, _ = _forward(model, x_adv, mc_sample)
        ce_clean = criterion(logits_nat, y, kl_nat, kl_weight)
        kl_out = F.kl_div(logits_adv, logits_nat.exp(), reduction='batchmean')

        loss = ce_clean + beta * kl_out

        return loss, {"clean_ce": ce_clean.item(), "kl": kl_out.item()}


def loss_mart(model, x, y, criterion, eps, alpha, steps, gamma, amp, model_type: str = "test", mc_sample: int = 1,
              kl_weight: float = 0.1):
    x_adv = mart_adv(model, x, y, criterion, eps, alpha, steps, amp, model_type, mc_sample, kl_weight)

    if model_type == "test":
        logits_nat = model(x)
        logits_adv = model(x_adv)
        py = F.softmax(logits_nat, dim=1).gather(1, y.view(-1, 1)).squeeze(1)
        ce_adv = F.cross_entropy(logits_adv, y, reduction="none")
        weighted_ce = (ce_adv * (1.0 - py.detach())).mean()
        rkl = F.kl_div(F.log_softmax(logits_nat, dim=1), F.softmax(logits_adv, dim=1), reduction='batchmean')
        loss = weighted_ce + gamma * rkl
        return loss, {"w_adv_ce": weighted_ce.item(), "rev_kl": rkl.item()}
    elif model_type == "test_bnn":
        logits_nat, kl_nat = _forward(model, x, mc_sample)
        logits_adv, _ = _forward(model, x_adv, mc_sample)
        py = torch.exp(logits_nat).gather(1, y.view(-1, 1)).squeeze(1)
        ce_adv = F.nll_loss(logits_adv, y, reduction="none")
        weighted_ce = (ce_adv * (1.0 - py.detach())).mean()
        rkl = F.kl_div(logits_nat, logits_adv.exp(), reduction='batchmean')
        loss = weighted_ce + gamma * rkl + kl_weight * kl_nat / criterion.train_size
        return loss, {"w_adv_ce": weighted_ce.item(), "rev_kl": rkl.item()}


def loss_gradalign(model, x, y, criterion, eps, alpha, steps, lambda_ga, amp, model_type: str = "test",
                   mc_sample: int = 1, kl_weight: float = 0.1):
    x_adv = pgd_linf(model, x, y, criterion, eps, alpha, steps, random_start=True, use_amp=amp, model_type=model_type,
                     mc_sample=mc_sample, kl_weight=kl_weight)

    x_clean = x.detach().requires_grad_(True)
    if model_type == "test":
        logits_clean = _forward(model, x_clean, mc_sample=1)
        ce_clean = criterion(logits_clean, y)
    elif model_type == "test_bnn":
        logits_clean, kl_clean = _forward(model, x_clean, mc_sample=mc_sample)
        ce_clean = criterion(logits_clean, y, kl_clean, kl_weight)
    grad_clean = torch.autograd.grad(ce_clean, x_clean, create_graph=False, retain_graph=False)[0]

    x_adv_req = x_adv.detach().requires_grad_(True)
    if model_type == "test":
        logits_adv = _forward(model, x_adv_req, mc_sample=1)
        ce_adv = criterion(logits_adv, y)
    elif model_type == "test_bnn":
        logits_adv, kl_adv = _forward(model, x_adv_req, mc_sample=mc_sample)
        ce_adv = criterion(logits_adv, y, kl_adv, kl_weight)
    grad_adv = torch.autograd.grad(ce_adv, x_adv_req, create_graph=False, retain_graph=True)[0]

    B = x.size(0)
    gc = grad_clean.view(B, -1)
    ga = grad_adv.view(B, -1)

    eps_norm = 1e-12
    gc = gc / (gc.norm(p=2, dim=1, keepdim=True) + eps_norm)
    ga = ga / (ga.norm(p=2, dim=1, keepdim=True) + eps_norm)
    cos = (gc * ga).sum(dim=1).mean()
    loss = ce_adv + lambda_ga * (1.0 - cos)

    return loss, {"ce_adv": ce_adv.item(), "cos": float(cos.detach().cpu())}


# -----------------------------
# Pure IBP
# -----------------------------

def _bn_affine_params(bn: nn.BatchNorm2d):
    a = bn.weight / torch.sqrt(bn.running_var + bn.eps)
    b = bn.bias - a * bn.running_mean
    return a.view(1, -1, 1, 1), b.view(1, -1, 1, 1)


def _affine_bounds(l, u, a, b):
    lo = torch.minimum(a * l + b, a * u + b)
    up = torch.maximum(a * l + b, a * u + b)
    return lo, up


def _conv_bounds(conv: nn.Conv2d, l, u):
    W = conv.weight
    b = conv.bias if conv.bias is not None else torch.zeros(W.size(0), device=W.device)
    Wp = torch.clamp(W, min=0)
    Wn = torch.clamp(W, max=0)
    lo = F.conv2d(l, Wp, bias=None, stride=conv.stride, padding=conv.padding, dilation=conv.dilation,
                  groups=conv.groups) \
         + F.conv2d(u, Wn, bias=None, stride=conv.stride, padding=conv.padding, dilation=conv.dilation,
                    groups=conv.groups)
    up = F.conv2d(u, Wp, bias=None, stride=conv.stride, padding=conv.padding, dilation=conv.dilation,
                  groups=conv.groups) \
         + F.conv2d(l, Wn, bias=None, stride=conv.stride, padding=conv.padding, dilation=conv.dilation,
                    groups=conv.groups)
    lo = lo + b.view(1, -1, 1, 1)
    up = up + b.view(1, -1, 1, 1)
    return lo, up


def _linear_bounds(fc: nn.Linear, l, u):
    W = fc.weight
    b = fc.bias if fc.bias is not None else torch.zeros(W.size(0), device=W.device)
    Wp = torch.clamp(W, min=0)
    Wn = torch.clamp(W, max=0)
    lo = l @ Wp.t() + u @ Wn.t() + b
    up = u @ Wp.t() + l @ Wn.t() + b
    return lo, up


def propagate_ibp_simplecnn(model: nn.Module, l, u):
    def _prop_module(m: nn.Module, l, u, flattened: bool):
        # Conv2d
        if isinstance(m, nn.Conv2d):
            l, u = _conv_bounds(m, l, u)
            return l, u, flattened

        # BatchNorm2d
        elif isinstance(m, nn.BatchNorm2d):
            a, b = _bn_affine_params(m)
            l, u = _affine_bounds(l, u, a, b)
            return l, u, flattened

        # ReLU
        elif isinstance(m, nn.ReLU):
            l = F.relu(l)
            u = F.relu(u)
            return l, u, flattened

        # MaxPool2d
        elif isinstance(m, nn.MaxPool2d):
            l = F.max_pool2d(l, m.kernel_size, m.stride, m.padding, m.dilation, m.ceil_mode, m.return_indices)
            u = F.max_pool2d(u, m.kernel_size, m.stride, m.padding, m.dilation, m.ceil_mode, m.return_indices)
            return l, u, flattened

        # AdaptiveAvgPool2d
        elif isinstance(m, nn.AdaptiveAvgPool2d):
            l = F.adaptive_avg_pool2d(l, m.output_size)
            u = F.adaptive_avg_pool2d(u, m.output_size)
            return l, u, flattened

        # Flatten（如果你有显式 nn.Flatten）
        elif isinstance(m, nn.Flatten):
            l = torch.flatten(l, 1)
            u = torch.flatten(u, 1)
            return l, u, True

        # Linear
        elif isinstance(m, nn.Linear):
            # 如果还没 flatten，则在第一次 Linear 前 flatten 一下
            if not flattened:
                l = torch.flatten(l, 1)
                u = torch.flatten(u, 1)
                flattened = True
            l, u = _linear_bounds(m, l, u)
            return l, u, flattened

        # Sequential：递归处理
        elif isinstance(m, nn.Sequential):
            for sub in m:
                l, u, flattened = _prop_module(sub, l, u, flattened)
            return l, u, flattened
        else:
            return l, u, flattened

    flattened = False
    for child in model.children():
        l, u, flattened = _prop_module(child, l, u, flattened)

    # 如果到了最后还没 flatten（比如全是 conv，没有 Linear），这里补一下
    if not flattened:
        l = torch.flatten(l, 1)
        u = torch.flatten(u, 1)

    return l, u


def propagate_ibp_testm(model: Testm, l, u):
    # conv1 + ReLU
    l, u = _conv_bounds(model.conv1, l, u)
    l = F.relu(l)
    u = F.relu(u)

    # maxpool2d(kernel_size=3, stride=3)
    l = F.max_pool2d(l, kernel_size=3, stride=3)
    u = F.max_pool2d(u, kernel_size=3, stride=3)

    # conv2 + ReLU
    l, u = _conv_bounds(model.conv2, l, u)
    l = F.relu(l)
    u = F.relu(u)

    # maxpool2d(kernel_size=2, stride=2)
    l = F.max_pool2d(l, kernel_size=2, stride=2)
    u = F.max_pool2d(u, kernel_size=2, stride=2)

    # flatten
    l = torch.flatten(l, 1)
    u = torch.flatten(u, 1)

    # fc1
    l, u = _linear_bounds(model.fc1, l, u)
    return l, u


def _denorm(x, mean, std):
    device = x.device
    mean = torch.tensor(mean, device=device).view(1, -1, 1, 1)
    std = torch.tensor(std, device=device).view(1, -1, 1, 1)
    return x * std + mean


def _renorm(x, mean, std):
    device = x.device
    mean = torch.tensor(mean, device=device).view(1, -1, 1, 1)
    std = torch.tensor(std, device=device).view(1, -1, 1, 1)
    return (x - mean) / std


def loss_ibp(model, x, y, eps: float, mean, std, ce_weight: float = 1.0, ibp_weight: float = 1.0):
    x_raw = _denorm(x, mean, std)
    l_raw = (x_raw - eps).clamp(0, 1)
    u_raw = (x_raw + eps).clamp(0, 1)
    l = _renorm(l_raw, mean, std)
    u = _renorm(u_raw, mean, std)

    was_training = model.training
    model.eval()
    if isinstance(model, Testm):
        l_logits, u_logits = propagate_ibp_testm(model, l, u)
    else:
        l_logits, u_logits = propagate_ibp_simplecnn(model, l, u)
    if was_training:
        model.train()

    B = y.size(0)
    num_classes = u_logits.size(1)
    fy_lb = l_logits.gather(1, y.view(-1, 1)).squeeze(1)
    mask = torch.ones(B, num_classes, dtype=torch.bool, device=x.device)
    mask.scatter(1, y.view(-1, 1), False)
    fj_ub = u_logits.masked_fill(~mask, float('-inf')).max(dim=1).values

    margin_lb = fy_lb - fj_ub

    ibp_loss = F.relu(- margin_lb).mean()

    logits_nat = model(x)
    ce = F.cross_entropy(logits_nat, y)

    total_loss = ce_weight * ce + ibp_weight * ibp_loss

    return total_loss, {"ibp_margin_lb": margin_lb.mean().item(), "ce": ce.item(), "ibp_loss": ibp_loss.item()}


# -----------------------------
# Randomized Smoothing (training & certification)
# -----------------------------

def loss_smoothing(model, x, y, criterion, sigma: float, model_type: str = "test", mc_sample: int = 1,
                   kl_weight: float = 0.0):
    noise = torch.randn_like(x) * sigma
    if model_type == "test":
        logits = _forward(model, (x + noise).clamp(0.0, 1.0), 1)
        ce = criterion(logits, y)
        return ce, {"sigma": sigma}
    elif model_type == "test_bnn":
        logits, kl = _forward(model, (x + noise).clamp(0.0, 1.0), mc_sample)
        ce = criterion(logits, y, kl, kl_weight)
        return ce, {"sigma": sigma}


def _clopper_pearson_lower(k: int, n: int, alpha: float) -> float:
    return sps.beta.ppf(alpha, k, n - k + 1)
    # if n == 0:
    #     return 0.0
    # p = k / n
    # z = 3.2905267314919255  # approx for alpha=0.001
    # denom = 1 + z * z / n
    # center = (p + z * z / (2 * n)) / denom
    # rad = (z * math.sqrt((p * (1 - p) + z * z / (4 * n)) / n)) / denom
    # return max(0.0, center - rad)


def certify_batch(model, x, sigma: float, n0: int = 100, n: int = 1000, alpha: float = 0.001, model_type: str = 'test',
                  mc_sample: int = 1) -> Tuple[torch.Tensor, torch.Tensor, torch.Tensor]:
    model.eval()
    with torch.no_grad():
        # class selection
        if model_type == 'test':
            num_classes = _forward(model, x[:1], 1).size(1)
        elif model_type == 'test_bnn':
            logits, _ = _forward(model, x[:1], 2)
            num_classes = logits.size(1)
        counts0 = torch.zeros(x.size(0), num_classes, dtype=torch.long, device=device)
        for _ in range(n0):
            if model_type == 'test':
                yhat = _forward(model, (x + torch.randn_like(x) * sigma).clamp(0, 1), 1).argmax(1)
            elif model_type == 'test_bnn':
                yhat, _ = _forward(model, (x + torch.randn_like(x) * sigma).clamp(0, 1), mc_sample)
                yhat = yhat.argmax(1)
            counts0.scatter_add_(1, yhat.view(-1, 1), torch.ones_like(yhat.view(-1, 1), dtype=torch.long))
        topk = counts0.argmax(dim=1)
        counts = torch.zeros(x.size(0), num_classes, dtype=torch.long, device=device)
        for _ in range(n):
            if model_type == 'test':
                yhat = _forward(model, (x + torch.randn_like(x) * sigma).clamp(0, 1), 1).argmax(1)
            elif model_type == 'test_bnn':
                yhat, _ = _forward(model, (x + torch.randn_like(x) * sigma).clamp(0, 1), mc_sample)
                yhat = yhat.argmax(1)
            counts.scatter_add_(1, yhat.view(-1, 1), torch.ones_like(yhat.view(-1, 1), dtype=torch.long))
        kA = counts.gather(1, topk.view(-1, 1)).squeeze(1)
        pA_lower = torch.tensor([_clopper_pearson_lower(int(k.item()), n, alpha) for k in kA], device=device)
        radii = sigma * (torch.sqrt(torch.tensor(2.0, device=device)) * tspecial.erfinv(2 * pA_lower - 1))
        radii = torch.nan_to_num(radii, nan=0.0, posinf=0.0, neginf=0.0)
        return topk, radii, pA_lower


# -----------------------------
# Evaluation (PGD & AutoAttack)
# -----------------------------

def evaluate_ibp_certified(model, loader, eps, mean, std):
    model.eval()
    total = 0
    certified = 0

    with torch.no_grad():
        for x, y in loader:
            x, y = x.to(device), y.to(device)

            x_raw = _denorm(x, mean, std)
            l_raw = (x_raw - eps).clamp(0, 1)
            u_raw = (x_raw + eps).clamp(0, 1)
            l = _renorm(l_raw, mean, std)
            u = _renorm(u_raw, mean, std)
            if isinstance(model, Testm):
                l_logits, u_logits = propagate_ibp_testm(model, l, u)
            else:
                l_logits, u_logits = propagate_ibp_simplecnn(model, l, u)

            B = y.size(0)
            num_classes = u_logits.size(1)
            fy_lb = l_logits.gather(1, y.view(-1, 1)).squeeze(1)
            mask = torch.ones(B, num_classes, dtype=torch.bool, device=x.device)
            mask.scatter(1, y.view(-1, 1), False)
            fj_ub = u_logits.masked_fill(~mask, float('-inf')).max(dim=1).values
            margin_lb = fy_lb - fj_ub

            total += B
            certified += (margin_lb > 0).sum().item()

        return certified / total


def evaluate(model, loader, criterion, eps_eval=0.3, steps=20, alpha=None, amp=False, model_type: str = 'test',
             mc_sample: int = 1, kl_weight: float = 0.1, eval_mc_sample: int = 1) -> Tuple[float, float]:
    model.eval()
    clean_correct = 0
    adv_correct = 0
    n = 0
    if alpha is None:
        alpha = eps_eval / 4.0
        # alpha = eps_eval
    for x, y in loader:
        x, y = x.to(device), y.to(device)
        with torch.no_grad():
            if model_type == 'test':
                pred = _forward(model, x, 1).argmax(1)
            elif model_type == 'test_bnn':
                pred, _ = _forward(model, x, eval_mc_sample)
                pred = pred.argmax(1)
        clean_correct += (pred == y).sum().item()

        if steps > 0 and eps_eval > 0:
            x_adv = pgd_linf(model, x, y, criterion, eps_eval, alpha, steps, random_start=True, use_amp=amp,
                             model_type=model_type, mc_sample=mc_sample, kl_weight=kl_weight)
            with torch.no_grad():
                if model_type == 'test':
                    pred_adv = _forward(model, x_adv, 1).argmax(1)
                elif model_type == 'test_bnn':
                    pred_adv, _ = _forward(model, x_adv, mc_sample=eval_mc_sample)
                    pred_adv = pred_adv.argmax(1)
            adv_correct += (pred_adv == y).sum().item()
        else:
            adv_correct += 0
        n += y.size(0)
    return clean_correct / n, adv_correct / n


# -----------------------------
# Main training loop
# -----------------------------


def train_one_epoch(model, loader, optimizer, criterion, scaler, args, epoch_idx: int = 1):
    model.train()
    total_loss = 0.0
    log_items = {}

    kl_w = args.kl_weight
    if args.model == 'test_bnn' and getattr(args, 'kl_anneal_epochs', 0) > 0:
        t = min(1.0, epoch_idx / max(1, args.kl_anneal_epochs))
        kl_w = args.kl_weight * t

    for i, (x, y) in enumerate(loader):
        x, y = x.to(device), y.to(device)
        optimizer.zero_grad(set_to_none=True)

        if args.method == 'pgd':
            loss, logs = loss_pgd_at(model, x, y, criterion, args.epsilon, args.alpha, args.steps, args.amp,
                                     args.model, args.mc_sample, kl_w)
        elif args.method == 'trades':
            loss, logs = loss_trades(model, x, y, criterion, args.epsilon, args.alpha, args.steps, args.beta, args.amp,
                                     args.model, args.mc_sample, kl_w)
        elif args.method == 'mart':
            loss, logs = loss_mart(model, x, y, criterion, args.epsilon, args.alpha, args.steps, args.gamma, args.amp,
                                   args.model, args.mc_sample, kl_w)
        elif args.method == 'gradalign':
            loss, logs = loss_gradalign(model, x, y, criterion, args.epsilon, args.alpha, args.steps, args.lambda_ga,
                                        args.amp, args.model, args.mc_sample, kl_w)
        elif args.method == 'ibp':
            if args.model != 'test':
                raise NotImplementedError("Pure IBP mode currently supports --model cnn only.")
            loss, logs = loss_ibp(model, x, y, args.epsilon, 0, 1, ce_weight=1.0, ibp_weight=args.ibp_weight)
        elif args.method == 'smoothing':
            loss, logs = loss_smoothing(model, x, y, criterion, args.sigma, args.model, args.mc_sample, kl_w)
        else:
            raise ValueError

        if args.amp and scaler is not None:
            scaler.scale(loss).backward()
            scaler.step(optimizer)
            scaler.update()
        else:
            loss.backward()
            optimizer.step()

        total_loss += loss.item() * y.size(0)
        log_items = logs

    return total_loss / len(loader.dataset), log_items


def main(args):
    set_seed(args.seed)

    if args.alpha is None:
        args.alpha = args.epsilon / 4.0
        # args.alpha = args.epsilon

    train_set, test_set, inputs, num_classes = get_dataset(args.dataset)
    train_loader, valid_loader, test_loader = get_dataloader(train_set, test_set, valid_size=0.2,
                                                             batch_size=args.batch_size, num_workers=args.workers)

    if args.model == "test":
        ckpt_dir = f'checkpoints/{args.dataset}/non_bayesian'
        ckpt_name = f'checkpoints/{args.dataset}/non_bayesian/model_{args.method}_best.pt'
    elif args.model == "test_bnn":
        ckpt_dir = f'checkpoints/{args.dataset}/bayesian'
        ckpt_name = f'checkpoints/{args.dataset}/bayesian/model_{args.method}_best.pt'
    else:
        raise ValueError

    if not os.path.exists(ckpt_dir):
        os.makedirs(ckpt_dir, exist_ok=True)

    if args.method == "ibp" and args.model == "test_bnn":
        print(f"Building a CNN from BayesCNN model")
        file_path = r"checkpoints/MNIST/bayesian/model_test_lrt_relu_clt_10.pt"
        model = build_cnn_from_bnn(file_path, inputs, num_classes)
        args.model = "test"
        assert args.mc_sample <= 1
        criterion = nn.CrossEntropyLoss()
        if not args.training:
            file_path = fr"checkpoints/MNIST/bayesian/model_{args.method}_best.pt"
            model.load_state_dict(torch.load(file_path, map_location=device)['model'])
    else:
        model = get_model(args.model, inputs, num_classes).to(device)
        if args.model == "test":
            assert args.mc_sample <= 1

            if args.training:
                file_path = r"checkpoints/MNIST/non_bayesian/model_test.pt"
                model.load_state_dict(torch.load(file_path, map_location=device))
            else:
                file_path = r"checkpoints/CIFAR10/non_bayesian/model_test.pt"
                model.load_state_dict(torch.load(file_path, map_location=device)['model'])

            criterion = nn.CrossEntropyLoss()
        elif args.model == "test_bnn":
            assert args.mc_sample > 1
            assert args.eval_mc_sample >= 8

            if args.training:
                file_path = r"checkpoints/MNIST/bayesian/model_test_lrt_relu_clt_10.pt"
                model.load_state_dict(torch.load(file_path, map_location=device))
            else:
                file_path = r"checkpoints/MNIST/bayesian/model_{args.method}_best.pt"
                model.load_state_dict(torch.load(file_path, map_location=device)['model'])

            criterion = metric.ELBO(len(train_set)).to(device)

    optimizer = torch.optim.Adam(model.parameters(), lr=args.lr, weight_decay=args.weight_decay)
    scheduler = torch.optim.lr_scheduler.MultiStepLR(optimizer,
                                                     milestones=[int(args.epochs * 0.25), int(args.epochs * 0.75)],
                                                     gamma=0.1)
    #scheduler = torch.optim.lr_scheduler.ReduceLROnPlateau(optimizer, patience=6)
    scaler = torch.amp.GradScaler(args.amp, enabled=True)

    model.to(device)

    print(f"Device: {device} | dataset={args.dataset} | model={args.model}")
    print(f"Method: {args.method} | eps={args.epsilon:.4f}, alpha={args.alpha:.4f}, steps={args.steps}")

    best_robust = 0.0
    acc_delta = 0.02  # accuracy decrease threshold
    # acc_test = 0.9841  # accuracy on test set: CNN
    acc_test = 0.9848  # accuracy on test set: BayesCNN
    if args.training:
        for epoch in range(1, args.epochs + 1):
            train_loss, logs = train_one_epoch(model, train_loader, optimizer, criterion, scaler, args, epoch)
            # scheduler.step(train_loss)
            msg = f"Epoch {epoch:03d} | train loss {train_loss:.4f} | logs {logs}"

            if args.method == 'ibp':
                cert_acc = evaluate_ibp_certified(model, test_loader,
                                                  eps=args.eval_eps,
                                                  mean=0,
                                                  std=1)
                print(f"IBP certified accuracy at eps={args.eval_eps}: {cert_acc * 100:.2f}%")

            best_metric = -1.0
            metric_mode = "robust" if (not args.no_robust_eval and args.method not in ['ibp', 'smoothing']) else "clean"
            clean_acc, robust_acc = None, None
            if metric_mode == 'robust':
                clean_acc, robust_acc = evaluate(model, test_loader, criterion, eps_eval=args.eval_eps,
                                                 steps=args.eval_steps, amp=args.amp, model_type=args.model,
                                                 mc_sample=args.mc_sample, kl_weight=args.kl_weight,
                                                 eval_mc_sample=args.eval_mc_sample)
                msg += f" | clean {clean_acc * 100:.2f}% | robust(PGD) {robust_acc * 100:.2f}%"
                if robust_acc > best_robust and clean_acc >= (acc_test - acc_delta):
                    best_robust = robust_acc
                    best_metric = robust_acc
                    torch.save({'epoch': epoch, 'model': model.state_dict(), 'optimizer': optimizer.state_dict(),
                                'args': vars(args), 'robust_acc': robust_acc, 'clean_acc': clean_acc}, ckpt_name)
                    msg += f" | saved {ckpt_name}"
            else:
                clean_acc, robust_acc = evaluate(model, test_loader, criterion, eps_eval=args.eval_eps,
                                                 steps=args.eval_steps, amp=args.amp, model_type=args.model,
                                                 mc_sample=args.mc_sample, kl_weight=args.kl_weight,
                                                 eval_mc_sample=args.eval_mc_sample)
                if robust_acc > best_robust and clean_acc >= (acc_test - acc_delta):
                    best_robust = robust_acc
                    torch.save({'epoch': epoch, 'model': model.state_dict(), 'optimizer': optimizer.state_dict(),
                                'args': vars(args), 'robust_acc': robust_acc, 'clean_acc': clean_acc}, ckpt_name)
                    msg += f" | saved {ckpt_name}"
                msg += f" | clean {clean_acc * 100:.2f}% | robust {robust_acc * 100: .2f}%"
            print(msg)

            if args.method == 'smoothing' and args.certify and epoch == args.epochs:
                model.eval()
                total = 0
                certified = 0
                radii_sum = 0.0
                for x, y in test_loader:
                    x, y = x.to(device), y.to(device)
                    pred, radii, _ = certify_batch(model, x, sigma=args.sigma, n0=args.n0, n=args.n,
                                                   alpha=args.alpha_cert,
                                                   model_type=args.model, mc_sample=args.mc_sample)
                    total += y.size(0)
                    certified += (pred == y).sum().item()
                    radii_sum += radii.clamp_min(0).sum().item()
                print(f"[Certify] top-1 agree {certified / total * 100:.2f}% | avg radius {radii_sum / total:.4f}")

            scheduler.step()

        print("Training complete.")
    else:
        msg = f"Evaluating...\n"
        msg += f"Model {args.model} | Method {args.method} | Epsilon {args.eval_eps} | Steps {args.eval_steps}"

        clean_acc, robust_acc = evaluate(model, test_loader, criterion, eps_eval=args.eval_eps,
                                         steps=args.eval_steps, amp=args.amp, model_type=args.model,
                                         mc_sample=args.mc_sample, kl_weight=args.kl_weight,
                                         eval_mc_sample=args.eval_mc_sample)

        msg += f" | clean {clean_acc * 100:.2f}% | robust(PGD) {robust_acc * 100:.2f}%\n"

        msg += f"Evaluation complete"

        print(msg)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Adversarial Training: CIFAR-10 / MNIST")
    parser.add_argument('--training', type=bool, default=True, choices=[True, False], help="adversarial training or "
                                                                                            "evaluation")
    parser.add_argument('--dataset', type=str, default='MNIST', choices=['CIFAR10', 'MNIST'])
    parser.add_argument('--method', type=str, default='mart',
                        choices=['pgd', 'trades', 'mart', 'gradalign', 'ibp', 'smoothing'], help='training method')
    parser.add_argument('--model', type=str, default='test_bnn', choices=['test', 'test_bnn'])
    parser.add_argument('--mc_sample', type=int, default=4, help="monte carlo samples")
    parser.add_argument('--kl_weight', type=float, default=1e-5, help='kl weight for BayesNN model')
    parser.add_argument('--kl_anneal_epochs', type=int, default=0,
                        help='linearly ramp up kl_weight over this many epochs (BNN only)')
    parser.add_argument('--epochs', type=int, default=120)
    parser.add_argument('--batch-size', type=int, default=256)
    parser.add_argument('--lr', type=float, default=1e-3)
    parser.add_argument('--weight-decay', type=float, default=1e-4)
    parser.add_argument('--epsilon', type=float, default=0.1, help='Linf epsilon (on [0,1] scale)')
    parser.add_argument('--alpha', type=float, default=None, help='PGD step size; default eps/4')
    parser.add_argument('--steps', type=int, default=10, help='PGD steps for training')
    parser.add_argument('--beta', type=float, default=1.5, help='TRADES KL weight')
    parser.add_argument('--gamma', type=float, default=0.2, help='MART reverse-KL weight')
    parser.add_argument('--lambda-ga', type=float, default=0.5, help='GradAlign weight')

    # Randomized smoothing
    parser.add_argument('--sigma', type=float, default=0.6, help='Gaussian std for smoothing training/cert')
    parser.add_argument('--certify', action='store_true',
                        help='run randomized smoothing certification on test set end of epoch')
    parser.add_argument('--n0', type=int, default=100)
    parser.add_argument('--n', type=int, default=1000)
    parser.add_argument('--alpha-cert', type=float, default=0.001)

    # IBP
    parser.add_argument('--ibp_weight', type=float, default=0.015, help=' weight for IBP loss term')

    # Eval
    parser.add_argument('--eval-eps', type=float, default=0.1, help='robust eval PGD epsilon')
    parser.add_argument('--eval-steps', type=int, default=10, help='robust eval PGD steps')
    parser.add_argument('--eval-aa', action='store_true', help='also evaluate AutoAttack if available')
    parser.add_argument('--no_robust_eval', action='store_true', help='skip PGD robust evaluation each epoch')
    parser.add_argument('--eval_mc_sample', type=int, default=10, help='mc_sample for BayesNN and CNN')

    parser.add_argument('--seed', type=str, default='time', help='random seeds')
    parser.add_argument('--amp', type=str, default='cuda', help='cuda or cpu')
    parser.add_argument('--workers', type=int, default=4)

    args = parser.parse_args()
    main(args)
