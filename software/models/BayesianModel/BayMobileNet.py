import torch
import torch.nn as nn

from layers import BBB_Conv2d, BBB_Linear
from layers import BBB_LRT_Conv2d, BBB_LRT_Linear
from layers import ModuleWrapper

# ---------------------------
#  Bayesian MobileNetV1 (BBB)
# ---------------------------

def _bbb_dw_pw_block(in_channels,
                     out_channels,
                     stride,
                     BBBConv2d,
                     act_layer,
                     priors,
                     use_clt,
                     clt_num,
                     use_bn=True):
    layers = []

    # depthwise
    dw = BBBConv2d(
        in_channels,
        in_channels,
        kernel_size=3,
        stride=stride,
        padding=1,
        bias=True,
        priors=priors,
        clt=use_clt,
        clt_num=clt_num,
        groups=in_channels,
    )
    layers.append(dw)
    if use_bn:
        layers.append(nn.BatchNorm2d(in_channels))
    layers.append(act_layer())

    # pointwise
    pw = BBBConv2d(
        in_channels,
        out_channels,
        kernel_size=1,
        stride=1,
        padding=0,
        bias=True,
        priors=priors,
        clt=use_clt,
        clt_num=clt_num,
    )
    layers.append(pw)
    if use_bn:
        layers.append(nn.BatchNorm2d(out_channels))
    layers.append(act_layer())

    return nn.Sequential(*layers)


class BBBMobileNetV1(ModuleWrapper):
    def __init__(self,
                 outputs,           # num_classes
                 inputs,            # in_channels
                 priors,
                 layer_type="lrt",  # "lrt" or "bbb"
                 activation_type="relu",
                 width_mult=1.0,
                 use_bn=True,
                 clt=True,
                 clt_num=10,
                 dropout=0.2):
        super(BBBMobileNetV1, self).__init__()

        self.num_classes = outputs
        self.layer_type = layer_type
        self.priors = priors
        self.use_clt = clt
        self.clt_num = clt_num

        #  LRT / BBB
        lt = layer_type.lower()
        if lt == "bbb":
            BBBLinear = BBB_Linear
            BBBConv2d = BBB_Conv2d
        elif lt == "lrt":
            BBBLinear = BBB_LRT_Linear
            BBBConv2d = BBB_LRT_Conv2d
        else:
            raise ValueError(f"Undefined layer_type: {layer_type}")

        # act layer
        if activation_type == "softplus":
            act_layer = nn.Softplus
        elif activation_type == "relu":
            act_layer = nn.ReLU
        else:
            raise ValueError("Only 'softplus' and 'relu' are supported")

        self.act_layer = act_layer

        def c(ch):
            ch = int(ch * width_mult)
            return max(ch, 8)

        # -------- features ---------
        layers = []

        # stem: 3x3, stride=1
        stem_out = c(32)
        stem_conv = BBBConv2d(
            inputs,
            stem_out,
            kernel_size=3,
            stride=1,
            padding=1,
            bias=True,
            priors=self.priors,
            clt=self.use_clt,
            clt_num=self.clt_num,
        )
        layers.append(stem_conv)
        if use_bn:
            layers.append(nn.BatchNorm2d(stem_out))
        layers.append(act_layer())

        in_c = stem_out

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

        for out_c, s in cfg:
            out_c = c(out_c)
            block = _bbb_dw_pw_block(
                in_channels=in_c,
                out_channels=out_c,
                stride=s,
                BBBConv2d=BBBConv2d,
                act_layer=act_layer,
                priors=self.priors,
                use_clt=self.use_clt,
                clt_num=self.clt_num,
                use_bn=use_bn,
            )
            layers.append(block)
            in_c = out_c

        self.features = nn.Sequential(*layers)

        # -------- classifier  --------
        self.classifier = nn.Sequential(
            nn.AdaptiveAvgPool2d(1),
            nn.Flatten(start_dim=1),
            nn.Dropout(p=dropout),
            BBBLinear(
                in_c,
                outputs,
                bias=True,
                priors=self.priors,
                clt=self.use_clt,
                clt_num=self.clt_num,
            )
        )

        self._init_bn()

    def _init_bn(self):
        for m in self.modules():
            if isinstance(m, nn.BatchNorm2d):
                nn.init.constant_(m.weight, 1.0)
                nn.init.constant_(m.bias, 0.0)
