import torch
import torch.nn as nn
import torch.nn.functional as F

# ---------------------------
#  Deterministic MobileNetV1
# ---------------------------

def _conv_bn_relu(in_channels, out_channels, stride=1, use_bn=True):
    layers = [
        nn.Conv2d(in_channels, out_channels,
                  kernel_size=3, stride=stride, padding=1,
                  bias=not use_bn)
    ]
    if use_bn:
        layers.append(nn.BatchNorm2d(out_channels))
    layers.append(nn.ReLU(inplace=True))
    return nn.Sequential(*layers)


def _dw_pw_block(in_channels, out_channels, stride=1, use_bn=True):
    """Depthwise + Pointwise block."""
    layers = []
    # depthwise conv
    layers.append(
        nn.Conv2d(in_channels, in_channels,
                  kernel_size=3, stride=stride, padding=1,
                  groups=in_channels,
                  bias=not use_bn)
    )
    if use_bn:
        layers.append(nn.BatchNorm2d(in_channels))
    layers.append(nn.ReLU(inplace=True))

    # pointwise conv
    layers.append(
        nn.Conv2d(in_channels, out_channels,
                  kernel_size=1, stride=1, padding=0,
                  bias=not use_bn)
    )
    if use_bn:
        layers.append(nn.BatchNorm2d(out_channels))
    layers.append(nn.ReLU(inplace=True))

    return nn.Sequential(*layers)


class MobileNetV1(nn.Module):
    def __init__(self,
                 num_classes=100,
                 inputs=3,
                 width_mult=1.0,
                 use_bn=True,
                 dropout=0.3):
        super(MobileNetV1, self).__init__()

        def c(ch):
            ch = int(ch * width_mult)
            return max(ch, 8)

        # stem: conv3x3, stride=1（适配 CIFAR/TinyImageNet）
        in_c = c(32)
        self.stem = _conv_bn_relu(inputs, in_c, stride=1, use_bn=use_bn)

        # MobileNetV1 的 (out_channels, stride) 配置（原始 ImageNet 版）
        cfg = [
            (64,   1),
            (128,  2),
            (128,  1),
            (256,  2),
            (256,  1),
            (512,  2),
            (512,  1),
            (512,  1),
            (512,  1),
            (512,  1),
            (512,  1),
            (1024, 2),
            (1024, 1),
        ]

        blocks = []
        for out_c, s in cfg:
            out_c = c(out_c)
            blocks.append(_dw_pw_block(in_c, out_c, stride=s, use_bn=use_bn))
            in_c = out_c

        self.features = nn.Sequential(*blocks)

        self.avgpool = nn.AdaptiveAvgPool2d(1)
        self.classifier = nn.Sequential(
            nn.Dropout(p=dropout),
            nn.Linear(in_c, num_classes)
        )

        self._init_weights()

    def _init_weights(self):
        for m in self.modules():
            if isinstance(m, nn.Conv2d):
                nn.init.kaiming_normal_(m.weight, mode="fan_out",
                                        nonlinearity="relu")
                if m.bias is not None:
                    nn.init.constant_(m.bias, 0.0)
            elif isinstance(m, nn.BatchNorm2d):
                nn.init.constant_(m.weight, 1.0)
                nn.init.constant_(m.bias, 0.0)
            elif isinstance(m, nn.Linear):
                nn.init.normal_(m.weight, 0.0, 0.01)
                nn.init.constant_(m.bias, 0.0)

    def forward(self, x):
        x = self.stem(x)
        x = self.features(x)
        x = self.avgpool(x)
        x = torch.flatten(x, 1)
        x = self.classifier(x)
        return x
