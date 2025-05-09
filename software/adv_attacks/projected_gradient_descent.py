import numpy as np
import torch
from adv_attacks.fast_gradient_method import fast_gradient_method
from adv_attacks.attack_utils import clip_eta

"""
This function implements either the Basic Iterative Method (BIM) when rand_init is set to False, or the PGD method if 
rand_init is set to True.
"""


def projected_gradient_descent(
        model_fn,
        x,
        eps,
        eps_iter,
        nb_iter,
        norm,
        num_ens,
        criterion,
        clip_min=0,
        clip_max=1,
        y=None,
        targeted=False,
        rand_init=True,
        rand_minmax=None,
        sanity_checks=True
):
    if norm == 1:
        raise NotImplementedError(
            "It's not clear that FGM is a good inner loop"
            " step for PGD when norm=1, because norm=1 FGM "
            " changes only one pixel at a time. We need "
            " to rigorously test a strong norm=1 PGD "
            "before enabling this feature."
        )
    if norm not in [np.inf, 2]:
        raise ValueError("Norm order must be either np.inf or 2.")

    if eps < 0:
        raise ValueError("eps must be greater than or equal to 0, got {} instead".format(eps))

    if eps == 0:
        return x

    if eps_iter < 0:
        raise ValueError("eps_iter must be greater than or equal to 0, got {} instead".format(eps_iter))

    if eps_iter == 0:
        return x

    assert eps_iter <= eps, (eps_iter, eps)

    if clip_min is not None and clip_max is not None:
        if clip_min > clip_max:
            raise ValueError(
                "clip_min must be less than or equal to clip_max, got clip_min={} and clip_max={}".format(clip_min,
                                                                                                          clip_max))
    asserts = []

    if clip_min is not None:
        assert_ge = torch.all(torch.ge(x, torch.tensor(clip_min, device=x.device, dtype=x.dtype))).cpu()
        asserts.append(assert_ge)

    if clip_max is not None:
        assert_le = torch.all(torch.le(x, torch.tensor(clip_max, device=x.device, dtype=x.dtype))).cpu()
        asserts.append(assert_le)

    if rand_init:
        if rand_minmax is None:
            rand_minmax = eps
        eta = torch.zeros_like(x).uniform_(-rand_minmax, rand_minmax)
    else:
        eta = torch.zeros_like(x)

    eta = clip_eta(eta, norm, eps)
    adv_x = x + eta

    mean = torch.tensor([0.491, 0.482, 0.446], device=x.device).view(1, 3, 1, 1)
    std = torch.tensor([0.247, 0.243, 0.261], device=x.device).view(1, 3, 1, 1)

    if clip_min is not None or clip_max is not None:
        if x.max() != 1 and x.min() != 0:
            clip_max = (clip_max - mean) / std
            clip_min = (clip_min - mean) / std
        adv_x = torch.clamp(adv_x, clip_min, clip_max)

    if y is None:
        _, y = torch.max(model_fn(x), 1)

    i = 0
    while i < nb_iter:
        adv_x = fast_gradient_method(
            model_fn,
            adv_x,
            eps_iter,
            norm,
            num_ens,
            criterion,
            clip_min=clip_min,
            clip_max=clip_max,
            y=y,
            targeted=targeted
        )
        eta = adv_x - x
        eta = clip_eta(eta, norm, eps)
        adv_x = x + eta

        if clip_min is not None or clip_max is not None:
            adv_x = torch.clamp(adv_x, clip_min, clip_max)
        i += 1

    asserts.append(eps_iter <= eps)

    if norm == np.inf and clip_min is not None:
        asserts.append((eps + clip_min <= clip_max).cpu())

    # if sanity_checks:
    #     assert np.all(asserts)
    return adv_x
