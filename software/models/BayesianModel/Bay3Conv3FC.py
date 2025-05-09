import torch.nn as nn
from layers import BBB_Linear, BBB_Conv2d
from layers import BBB_LRT_Linear, BBB_LRT_Conv2d
from layers import FlattenLayer, ModuleWrapper


class BBB3Conv3FC(ModuleWrapper):
    """docstring for BBB3Conv3FC"""

    def __init__(self, outputs, inputs, priors, layer_type="BBB", activation_type="softplus", clt=False, clt_num=25):
        super(BBB3Conv3FC, self).__init__()
        self.num_classes = outputs
        self.priors = priors
        self.use_clt = clt
        self.clt_num = clt_num

        if layer_type == "bbb":
            BBBLinear = BBB_Linear
            BBBConv2d = BBB_Conv2d
        elif layer_type == "lrt":
            BBBLinear = BBB_LRT_Linear
            BBBConv2d = BBB_LRT_Conv2d
        else:
            raise ValueError("Undefined layer_type")

        if activation_type == "softplus":
            self.act = nn.Softplus
        elif activation_type == "relu":
            self.act = nn.ReLU
        else:
            raise ValueError("Only softplus or relu supported")

        self.conv1 = BBBConv2d(inputs, 32, 5, padding=2, bias=True, priors=self.priors,
                               clt=self.use_clt, clt_num=self.clt_num)
        self.act1 = self.act()
        self.pool1 = nn.MaxPool2d(kernel_size=3, stride=2)

        self.conv2 = BBBConv2d(32, 64, 5, padding=2, bias=True, priors=self.priors,
                               clt=self.use_clt, clt_num=self.clt_num)
        self.act2 = self.act()
        self.pool2 = nn.MaxPool2d(kernel_size=3, stride=2)

        self.conv3 = BBBConv2d(64, 128, 5, padding=1, bias=True, priors=self.priors,
                               clt=self.use_clt, clt_num=self.clt_num)
        self.act3 = self.act()
        self.pool3 = nn.MaxPool2d(kernel_size=3, stride=2)

        self.flatten = FlattenLayer(2 * 2 * 128)
        self.fc1 = BBBLinear(2 * 2 * 128, 1000, bias=True, priors=self.priors,
                             clt=self.use_clt, clt_num=self.clt_num)
        self.act4 = self.act()

        self.fc2 = BBBLinear(1000, 1000, bias=True, priors=self.priors,
                             clt=self.use_clt, clt_num=self.clt_num)
        self.act5 = self.act()

        self.fc3 = BBBLinear(1000, outputs, bias=True, priors=self.priors,
                             clt=self.use_clt, clt_num=self.clt_num)
