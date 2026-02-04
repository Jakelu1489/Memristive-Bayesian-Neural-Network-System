import torch.nn as nn
import torch.nn.functional as F


def conv_init(m):
    class_name = m.__class__.__name__
    if class_name.find("Conv") != -1:
        nn.init.normal_(m.weight, mean=0, std=1)
        nn.init.constant(m.bias, 0)


class Testm2(nn.Module):
    """docstring for Testm"""
    """iso-area comparsion"""

    def __init__(self, outputs, inputs):
        super(Testm2, self).__init__()
        self.num_classes = outputs

        self.conv1 = nn.Conv2d(inputs, 16, 3, padding=0, bias=False)

        self.conv2 = nn.Conv2d(16, 16, 3, padding=0, bias=False)

        self.fc1 = nn.Linear(4 * 4 * 16, outputs, bias=False)

    def forward(self, x):
        x = F.relu(self.conv1(x))
        x = F.max_pool2d(x, kernel_size=3, stride=3)
        x = F.relu(self.conv2(x))
        x = F.max_pool2d(x, kernel_size=2, stride=2)
        x = x.view(x.size(0), -1)
        x = self.fc1(x)
        return x
