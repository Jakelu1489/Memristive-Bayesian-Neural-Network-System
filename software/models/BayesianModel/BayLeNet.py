import torch.nn as nn
from layers import BBB_Linear, BBB_Conv2d
from layers import BBB_LRT_Conv2d, BBB_LRT_Linear
from layers import FlattenLayer, ModuleWrapper


class BBBLeNet(ModuleWrapper):
    """docstring for BBBLeNet"""

    def __init__(self, outputs, inputs, priors, layer_type="bbb", activation_type="softplus", clt=False, clt_num=25):
        super(BBBLeNet, self).__init__()
        self.num_classes = outputs
        self.layer_type = layer_type
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

        self.conv1 = BBBConv2d(inputs, 6, 5, padding=0, bias=True, priors=self.priors,
                               clt=self.use_clt, clt_num=self.clt_num)
        self.act1 = self.act()
        self.pool1 = nn.MaxPool2d(kernel_size=2, stride=2)

        self.conv2 = BBBConv2d(6, 16, 5, padding=0, bias=True, priors=self.priors,
                               clt=self.use_clt, clt_num=self.clt_num)
        self.act2 = self.act()
        self.pool2 = nn.MaxPool2d(kernel_size=2, stride=2)

        self.flatten = FlattenLayer(5 * 5 * 16)
        self.fc1 = BBBLinear(5 * 5 * 16, 120, bias=True, priors=self.priors, clt=self.use_clt, clt_num=self.clt_num)
        self.act3 = self.act()

        self.fc2 = BBBLinear(120, 84, bias=True, priors=self.priors, clt=self.use_clt, clt_num=self.clt_num)
        self.act4 = self.act()

        self.fc3 = BBBLinear(84, outputs, bias=True, priors=self.priors, clt=self.use_clt, clt_num=self.clt_num)
