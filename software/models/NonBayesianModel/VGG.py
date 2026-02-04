import torch
import torch.nn as nn
import torch.nn.functional as F


cfg_vgg11 = [64, 'M',
             128, 'M',
             256, 256, 'M',
             512, 512, 'M',
             512, 512, 'M']


def make_layers(cfg, in_channels=3, batch_norm=True):
    layers = []
    for v in cfg:
        if v == 'M':
            layers += [nn.MaxPool2d(kernel_size=2, stride=2)]
        else:
            conv2d = nn.Conv2d(in_channels, v, kernel_size=3, padding=1)
            if batch_norm:
                layers += [conv2d, nn.BatchNorm2d(v), nn.ReLU(inplace=True)]
            else:
                layers += [conv2d, nn.ReLU(inplace=True)]
            in_channels = v
    return nn.Sequential(*layers)


class VGG11(nn.Module):
    def __init__(self, num_classes, inputs, use_bn=True, fc_dim=512, dropout=0.5):
        super(VGG11, self).__init__()

        self.features = make_layers(cfg_vgg11, inputs, batch_norm=use_bn)
        self.classifier = nn.Sequential(
            nn.Linear(512, fc_dim),
            nn.ReLU(inplace=True),
            nn.Dropout(p=dropout),
            nn.Linear(fc_dim, num_classes)
        )

        self._init_weights()

    def _init_weights(self):
        for m in self.modules():
            if isinstance(m, nn.Conv2d):
                nn.init.kaiming_normal_(m.weight, mode='fan_out',
                                        nonlinearity='relu')
                if m.bias is not None:
                    nn.init.constant_(m.bias, 0)
            elif isinstance(m, nn.Linear):
                nn.init.normal_(m.weight, 0, 0.01)
                nn.init.constant_(m.bias, 0)

    def forward(self, x):
        x = self.features(x)              # [B, 512, 1, 1]
        x = F.adaptive_avg_pool2d(x, 1)   # 保险一点，强制到 1x1
        x = torch.flatten(x, 1)           # [B, 512]
        x = self.classifier(x)            # [B, 100]
        return x
