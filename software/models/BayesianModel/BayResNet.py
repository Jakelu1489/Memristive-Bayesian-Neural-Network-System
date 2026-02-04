import torch
import torch.nn as nn
from layers import BBB_Conv2d, BBB_Linear
from layers import BBB_LRT_Conv2d, BBB_LRT_Linear
from layers import ModuleWrapper


class BBBBasicBlock(nn.Module):
    expansion = 1

    def __init__(self,
                 in_planes,
                 planes,
                 stride,
                 BBBConv2d,
                 act_layer,
                 priors,
                 use_clt,
                 clt_num):
        super(BBBBasicBlock, self).__init__()

        self.act = act_layer()

        # 主分支 conv1 / conv2
        self.conv1 = BBBConv2d(in_planes, planes,
                               kernel_size=3,
                               stride=stride,
                               padding=1,
                               bias=True,
                               priors=priors,
                               clt=use_clt,
                               clt_num=clt_num)
        self.bn1 = nn.BatchNorm2d(planes)

        self.conv2 = BBBConv2d(planes, planes,
                               kernel_size=3,
                               stride=1,
                               padding=1,
                               bias=True,
                               priors=priors,
                               clt=use_clt,
                               clt_num=clt_num)
        self.bn2 = nn.BatchNorm2d(planes)

        # shortcut / downsample
        self.downsample = None
        if stride != 1 or in_planes != planes * self.expansion:
            self.downsample = BBBConv2d(in_planes,
                                        planes * self.expansion,
                                        kernel_size=1,
                                        stride=stride,
                                        padding=0,
                                        bias=True,
                                        priors=priors,
                                        clt=use_clt,
                                        clt_num=clt_num)
            self.downsample_bn = nn.BatchNorm2d(planes * self.expansion)

    def forward(self, x):
        kl = 0.0

        out = self.conv1(x)
        if hasattr(self.conv1, "kl_loss"):
            kl += self.conv1.kl_loss()
        out = self.bn1(out)
        out = self.act(out)

        out = self.conv2(out)
        if hasattr(self.conv2, "kl_loss"):
            kl += self.conv2.kl_loss()
        out = self.bn2(out)

        # shortcut
        identity = x
        if self.downsample is not None:
            identity = self.downsample(x)
            if hasattr(self.downsample, "kl_loss"):
                kl += self.downsample.kl_loss()
            identity = self.downsample_bn(identity)

        out = out + identity
        out = self.act(out)

        return out, kl


class BBBResNet_CIFAR(ModuleWrapper):
    def __init__(self,
                 block,  # BBBBasicBlock
                 num_blocks,  # list, e.g. [2,2,2,2] or [3,4,6,3]
                 outputs,
                 inputs,
                 priors,
                 layer_type="lrt",
                 activation_type="relu",
                 clt=False,
                 clt_num=25):
        super(BBBResNet_CIFAR, self).__init__()

        self.num_classes = outputs
        self.layer_type = layer_type
        self.priors = priors
        self.use_clt = clt
        self.clt_num = clt_num
        self.in_planes = 64

        if layer_type == "bbb":
            BBBLinear = BBB_Linear
            BBBConv2d = BBB_Conv2d
        elif layer_type == "lrt":
            BBBLinear = BBB_LRT_Linear
            BBBConv2d = BBB_LRT_Conv2d
        else:
            raise ValueError("Undefined layer_type (use 'bbb' or 'lrt')")

        # 激活
        if activation_type == "softplus":
            self.act_layer = nn.Softplus
        elif activation_type == "relu":
            self.act_layer = nn.ReLU
        else:
            raise ValueError("Only softplus and relu supported")

        # ===== stem conv =====
        self.conv1 = BBBConv2d(inputs, 64,
                               kernel_size=3,
                               stride=1,
                               padding=1,
                               bias=True,
                               priors=self.priors,
                               clt=self.use_clt,
                               clt_num=self.clt_num)
        self.bn1 = nn.BatchNorm2d(64)
        self.act1 = self.act_layer()

        # ===== 4 个 stage =====
        # 32x32
        self.layer1 = self._make_layer(block, 64, num_blocks[0], stride=1,
                                       BBBConv2d=BBBConv2d)
        # 16x16
        self.layer2 = self._make_layer(block, 128, num_blocks[1], stride=2,
                                       BBBConv2d=BBBConv2d)
        # 8x8
        self.layer3 = self._make_layer(block, 256, num_blocks[2], stride=2,
                                       BBBConv2d=BBBConv2d)
        # 4x4
        self.layer4 = self._make_layer(block, 512, num_blocks[3], stride=2,
                                       BBBConv2d=BBBConv2d)

        # GAP + FC
        self.avgpool = nn.AdaptiveAvgPool2d((1, 1))

        self.fc = BBBLinear(512 * block.expansion, outputs, bias=True,
                            priors=self.priors, clt=self.use_clt, clt_num=self.clt_num)

        self._init_bn()

    def _init_bn(self):
        for m in self.modules():
            if isinstance(m, nn.BatchNorm2d):
                nn.init.constant_(m.weight, 1.0)  # γ
                nn.init.constant_(m.bias, 0.0)

    def _make_layer(self, block, planes, num_block, stride, BBBConv2d):
        strides = [stride] + [1] * (num_block - 1)
        layers = []

        for s in strides:
            layers.append(
                block(self.in_planes, planes, s,
                      BBBConv2d=BBBConv2d,
                      act_layer=self.act_layer,
                      priors=self.priors,
                      use_clt=self.use_clt,
                      clt_num=self.clt_num)
            )
            self.in_planes = planes * block.expansion

        return nn.ModuleList(layers)

    @staticmethod
    def _forward_layer(layer, x):
        kl = 0.0
        out = x
        for block in layer:
            out, kl_block = block(out)
            kl += kl_block
        return out, kl

    def forward(self, x):
        kl_total = 0.0

        # stem
        out = self.conv1(x)
        if hasattr(self.conv1, "kl_loss"):
            kl_total += self.conv1.kl_loss()
        out = self.bn1(out)
        out = self.act1(out)

        # 4 个 stage
        out, kl = self._forward_layer(self.layer1, out)
        kl_total += kl

        out, kl = self._forward_layer(self.layer2, out)
        kl_total += kl

        out, kl = self._forward_layer(self.layer3, out)
        kl_total += kl

        out, kl = self._forward_layer(self.layer4, out)
        kl_total += kl

        # GAP + FC
        out = self.avgpool(out)
        out = out.view(out.size(0), -1)

        out = self.fc(out)
        kl_total += self.fc.kl_loss()

        return out, kl_total


def BBBResNet18(outputs, inputs, priors,
                layer_type="lrt",
                activation_type="relu",
                clt=True,
                clt_num=10):
    # ResNet-18: [2, 2, 2, 2]
    return BBBResNet_CIFAR(
        block=BBBBasicBlock,
        num_blocks=[2, 2, 2, 2],
        outputs=outputs,
        inputs=inputs,
        priors=priors,
        layer_type=layer_type,
        activation_type=activation_type,
        clt=clt,
        clt_num=clt_num
    )


def BBBResNet34(outputs, inputs, priors,
                layer_type="lrt",
                activation_type="relu",
                clt=True,
                clt_num=10):
    # ResNet-34: [3, 4, 6, 3]
    return BBBResNet_CIFAR(
        block=BBBBasicBlock,
        num_blocks=[3, 4, 6, 3],
        outputs=outputs,
        inputs=inputs,
        priors=priors,
        layer_type=layer_type,
        activation_type=activation_type,
        clt=clt,
        clt_num=clt_num
    )