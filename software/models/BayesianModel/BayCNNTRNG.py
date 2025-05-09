import torch.nn as nn
from quan.func import QuanBayConv2dLRT, QuanBayLinearLRT


class BayCNNTRNG(nn.Module):
    def __init__(self):
        super(BayCNNTRNG, self).__init__()
        self.conv1 = QuanBayConv2dLRT()
        self.conv2 = QuanBayConv2dLRT()
        self.fc1 = QuanBayLinearLRT()
    def forward(self,):