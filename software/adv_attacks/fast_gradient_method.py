import numpy as np
import torch

import utils
from adv_attacks.attack_utils import optimize_linear
from torch.nn import functional as F


def fast_gradient_method(
        model_fn,
        x,
        eps,
        norm,
        num_ens,
        criterion,
        clip_max=1,
        clip_min=0,
        y=None,
        targeted=False,
        sanity_checks=True
):
    if norm not in [np.inf, 1, 2]:
        raise ValueError("Norm order must be either np.inf, 1, or 2, got {} instead.".format(norm))
    if eps < 0:
        raise ValueError("eps must be greater than or equal to 0, got {} instead".format(eps))
    if eps == 0:
        return x
    if clip_min is not None and clip_max is not None:
        if torch.any(clip_min > clip_max):
            raise ValueError(
                "clip_min must be less than or equal to clip_max, got clip_min={} and clip_max={}".format(clip_min,
                                                                                                          clip_max))

    asserts = []

    if clip_min is not None:
        assert_ge = torch.all(
            torch.ge(x, torch.tensor(clip_min, device=x.device, dtype=x.dtype))).clone().detach().cpu()
        asserts.append(assert_ge)
    if clip_max is not None:
        assert_le = torch.all(
            torch.le(x, torch.tensor(clip_max, device=x.device, dtype=x.dtype))).clone().detach().cpu()
        asserts.append(assert_le)
    x = x.clone().detach().to(torch.float).requires_grad_(True)

    if y is None:
        _, y = torch.max(model_fn(x), 1)
    loss = criterion(model_fn(x), y)  # for non-BayNN
    # kl = 0.0
    # outputs = torch.zeros(x.shape[0], model_fn.num_classes, num_ens).to(torch.device(x.device))  # 10 classes

    # for j in range(num_ens):
    #     net_out, _kl = model_fn(x)
    #     kl += _kl
    #     outputs[:, :, j] = F.log_softmax(net_out, dim=1)

    # kl /= num_ens
    # log_outputs = utils.logmeanexp(outputs, dim=2)
    # loss = criterion(log_outputs, y, kl, 0.1)
    if targeted:
        loss = -loss
    model_fn.zero_grad()
    loss.backward()
    optimal_perturbation = optimize_linear(x.grad.data, eps, norm)
    adv_x = x + optimal_perturbation
    if (clip_min is not None) or (clip_max is not None):
        if clip_min is None or clip_max is None:
            raise ValueError("One of clip_min and clip_max is None but we don't currently support one-sided clipping")
        adv_x = torch.clamp(adv_x, clip_min, clip_max)
    if sanity_checks:
        assert np.all(asserts)
    return adv_x
