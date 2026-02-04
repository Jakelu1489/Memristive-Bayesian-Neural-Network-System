import torch
import torch.nn as nn
import torch.nn.functional as F

from layers import BBB_Conv2d, BBB_Linear
from layers import BBB_LRT_Conv2d, BBB_LRT_Linear
from layers import ModuleWrapper

cfg_vgg11 = [
    64,  'M',
    128, 'M',
    256, 256, 'M',
    512, 512, 'M',
    512, 512, 'M'
]


def make_bbb_layers(cfg,
                    in_channels,
                    BBBConv2d,
                    act_layer,
                    priors,
                    use_bn=True,
                    clt=False,
                    clt_num=10):
    layers = []
    for v in cfg:
        if v == 'M':
            layers.append(nn.MaxPool2d(kernel_size=2, stride=2))
        else:
            conv = BBBConv2d(
                in_channels,
                v,
                kernel_size=3,
                padding=1,
                bias=True,
                priors=priors,
                clt=clt,
                clt_num=clt_num
            )
            if use_bn:
                layers.extend([
                    conv,
                    nn.BatchNorm2d(v),
                    act_layer()
                ])
            else:
                layers.extend([
                    conv,
                    act_layer()
                ])
            in_channels = v
    return nn.Sequential(*layers)


class BBBVGG11(ModuleWrapper):
    def __init__(self,
                 outputs,
                 inputs,
                 priors,
                 layer_type="lrt",
                 activation_type="relu",
                 clt=True,
                 clt_num=10,
                 use_bn=True,
                 fc_dim=512,
                 dropout=0.5):
        super(BBBVGG11, self).__init__()

        self.num_classes = outputs
        self.layer_type = layer_type
        self.priors = priors
        self.use_clt = clt
        self.clt_num = clt_num

        lt = layer_type.lower()
        if lt == "bbb":
            BBBLinear = BBB_Linear
            BBBConv2d = BBB_Conv2d
        elif lt == "lrt":
            BBBLinear = BBB_LRT_Linear
            BBBConv2d = BBB_LRT_Conv2d
        else:
            raise ValueError(f"Undefined layer_type: {layer_type}")

        if activation_type == "softplus":
            self.act = nn.Softplus
        elif activation_type == "relu":
            self.act = nn.ReLU
        else:
            raise ValueError("Only 'softplus' and 'relu' are supported")

        # ===== feature =====
        self.features = make_bbb_layers(
            cfg=cfg_vgg11,
            in_channels=inputs,
            BBBConv2d=BBBConv2d,
            act_layer=self.act,
            priors=self.priors,
            use_bn=use_bn,
            clt=self.use_clt,
            clt_num=self.clt_num
        )

        # adaptiveavgpool
        self.avgpool = nn.AdaptiveAvgPool2d((1, 1))

        # ===== classifier =====
        self.classifier = nn.Sequential(
            nn.Flatten(start_dim=1),
            BBBLinear(
                512,
                fc_dim,
                bias=True,
                priors=self.priors,
                clt=self.use_clt,
                clt_num=self.clt_num
            ),
            self.act(),
            nn.Dropout(p=dropout),
            BBBLinear(
                fc_dim,
                outputs,
                bias=True,
                priors=self.priors,
                clt=self.use_clt,
                clt_num=self.clt_num
            )
        )

        self._init_bn()

    def _init_bn(self):
        for m in self.modules():
            if isinstance(m, nn.BatchNorm2d):
                nn.init.constant_(m.weight, 1.0)
                nn.init.constant_(m.bias, 0.0)

    def forward(self, x):
        x = self.features(x)  # [B, 512, H', W']
        x = self.avgpool(x)  # [B, 512, 1, 1]
        x = self.classifier(x)  # [B, num_classes]

        kl = 0.0
        for m in self.modules():
            if (m is not self) and hasattr(m, "kl_loss"):
                kl = kl + m.kl_loss()

        return x, kl