import numpy as np
import torch


def clip_eta(eta, norm, eps):
    if norm not in [np.inf, 1, 2]:
        raise ValueError("norm must be np.inf, 1, or 2.")

    avoid_zero_div = torch.tensor(1e-12, dtype=eta.dtype, device=eta.device)
    reduc_ind = list(range(1, len(eta.size())))
    if norm == np.inf:
        eta = torch.clamp(eta, -eps, eps)
    else:
        if norm == 1:
            raise NotImplementedError("L1 clip is not implemented.")
        elif norm == 2:
            norm = torch.sqrt(torch.max(avoid_zero_div, torch.sum(eta ** 2, dim=reduc_ind, keepdim=True)))
            factor = torch.min(torch.tensor(1.0, dtype=eta.dtype, device=eta.device), eps / norm)
            eta *= factor
    return eta


def optimize_linear(grad, eps, norm=np.inf):
    red_ind = list(range(1, len(grad.size())))
    avoid_zero_div = torch.tensor(1e-12, dtype=grad.dtype, device=grad.device)
    if norm == np.inf:
        optimal_perturbation = torch.sign(grad)
    elif norm == 1:
        abs_grad = torch.abs(grad)
        sign = torch.sign(grad)
        red_ind = list(range(1, len(grad.size())))
        ori_shape = [1] * len(grad.size())
        ori_shape[0] = grad.size(0)

        max_abs_grad, _ = torch.max(abs_grad.view(grad.size(0), -1), 1)
        max_mask = abs_grad.eq(max_abs_grad.view(ori_shape)).to(torch.float)
        num_ties = max_mask
        for red_scalar in red_ind:
            num_ties = torch.sum(num_ties, red_scalar, keepdim=True)
        optimal_perturbation = sign * max_mask / num_ties
        opt_pert_norm = optimal_perturbation.abs().sum(dim=red_ind)
        assert torch.all(opt_pert_norm == torch.zeros_like(opt_pert_norm))
    elif norm == 2:
        square = torch.max(avoid_zero_div, torch.sum(grad ** 2, red_ind, keepdim=True))
        optimal_perturbation = grad / torch.sqrt(square)
        opt_pert_norm = (optimal_perturbation.pow(2).sum(dim=red_ind, keepdims=True).sqrt())
        one_mask = (square <= avoid_zero_div).to(torch.float) * opt_pert_norm + (square > avoid_zero_div).to(
            torch.float)
        assert torch.allclose(opt_pert_norm, one_mask, rtol=1e-5, atol=1e-8)
    else:
        raise NotImplementedError("Only L-inf, L1 and L2 norms are " "currently implemented.")
    scaled_perturbation = eps * optimal_perturbation
    return scaled_perturbation


def zero_out_clipped_grads(grad, x, clip_min, clip_max):
    signed_grad = torch.sign(grad)
    clip_low = torch.le(x, clip_min) & torch.lt(signed_grad, 0)
    clip_high = torch.ge(x, clip_max) & torch.gt(signed_grad, 0)
    clip = clip_low | clip_high
    grad = torch.where(clip, torch.zeros_like(grad), grad)

    return grad
