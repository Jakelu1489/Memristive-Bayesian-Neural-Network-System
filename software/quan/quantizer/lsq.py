import torch
from quan.quantizer.quantizer import Quantizer


def grad_scale(x, scale):
    y = x
    y_grad = x * scale
    return (y - y_grad).detach() + y_grad


def round_pass(x):
    y = x.round()
    y_grad = x
    return (y - y_grad).detach() + y_grad


class LsqQuan(Quantizer):
    def __init__(self, bit, all_positive=False, symmetric=False, per_channel=True):
        super(LsqQuan, self).__init__(bit)
        self.all_positive = all_positive
        if all_positive:
            assert not symmetric, "Positive quantization cannot be symmetric"
            self.thd_neg = 0
            self.thd_pos = 2 ** bit - 1
        else:
            if symmetric:
                self.thd_pos = 2 ** (bit - 1) - 1
                self.thd_neg = -2 ** (bit - 1) + 1
            else:
                self.thd_pos = 2 ** (bit - 1) - 1
                self.thd_neg = -2 ** (bit - 1)

        self.s = torch.nn.Parameter(torch.ones(1))
        self.per_channel = per_channel

    def init_from(self, x, *args, **kwargs):
        if self.per_channel:
            self.s = torch.nn.Parameter(
                x.detach().abs().mean(dim=list(range(1, x.dim())), keepdim=True) * 2 / (self.thd_pos ** 0.5))
        else:
            self.s = torch.nn.Parameter(x.detach().abs().mean() * 2 / (self.thd_pos ** 0.5))

    def forward(self, x):
        s_grad_scale = 1.0 / ((self.thd_pos * x.numel()) ** 0.5)
        s_scale = grad_scale(self.s, s_grad_scale)
        if torch.isnan(s_scale).any():
            raise ValueError("s_scale is nan")

        x = x / s_scale
        if not self.all_positive or s_scale.item() >= 0:
            x = torch.clamp(x, self.thd_neg, self.thd_pos)
        elif s_scale.item() < 0:
            x = torch.clamp(x, -self.thd_pos, -self.thd_neg)
        # x = torch.clamp(x, self.thd_neg, self.thd_pos)
        x = round_pass(x)
        x = x * s_scale
        return x
