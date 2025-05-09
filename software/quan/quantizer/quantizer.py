import torch.nn as nn


class Quantizer(nn.Module):
    def __init__(self, bit):
        super(Quantizer, self).__init__()

    def init_from(self, x):
        pass

    def forward(self, x):
        raise NotImplementedError


class IdentityQuan(Quantizer):
    def __init__(self, bit=None, *args, **kwargs):
        super(IdentityQuan, self).__init__(bit)
        assert bit is None, "The bit-width of identity quantizer must be None"

    def forward(self, x):
        return x