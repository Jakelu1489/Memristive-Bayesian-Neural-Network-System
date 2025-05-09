import torch
import numpy as np


def noise(x, eps=0.3, norm=np.inf, clip_min=None, clip_max=None):
    if norm != np.inf:
        raise NotImplementedError(norm)

    eta = torch.FloatTensor(*x.shape).to(x.device).uniform_(-eps, eps) # for uniform noise attack
    # eta = torch.FloatTensor(*x.shape).to(x.device).normal_(0, eps) # for gaussian noise attack
    adv_x = x + eta

    if clip_min is not None or clip_max is not None:
        assert clip_min is not None and clip_max is not None
        adv_x = torch.clamp(adv_x, clip_min, clip_max)

    return adv_x
