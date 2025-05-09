import torch.nn as nn
import torch.nn.functional as F


def conv_init(m):
    class_name = m.__class__.__name__
    if class_name.find("Conv") != -1:
        nn.init.normal_(m.weight, mean=0, std=1)
        nn.init.constant(m.bias, 0)


class Testm(nn.Module):
    """docstring for Testm"""

    def __init__(self, outputs, inputs):
        super(Testm, self).__init__()
        self.num_classes = outputs

        self.conv1 = nn.Conv2d(inputs, 8, 3, padding=0, bias=False)

        self.conv2 = nn.Conv2d(8, 8, 3, padding=0, bias=False)

        # self.flatten = FlattenLayer(4 * 4 * 5)
        self.fc1 = nn.Linear(4 * 4 * 8, outputs, bias=False)
        # self.act3 = self.act()

        # self.fc2 = BBBLinear(100, outputs, bias=True, priors=self.priors, clt=self.use_clt, clt_num=self.clt_num)
        # self.act4 = self.act()

        # self.fc3 = BBBLinear(84, outputs, bias=True, priors=self.priors, clt=self.use_clt, clt_num=self.clt_num)

    def forward(self, x):
        x = F.relu(self.conv1(x))
        x = F.max_pool2d(x, kernel_size=3, stride=3)
        x = F.relu(self.conv2(x))
        x = F.max_pool2d(x, kernel_size=2, stride=2)
        x = x.view(x.size(0), -1)
        x = self.fc1(x)
        return x
