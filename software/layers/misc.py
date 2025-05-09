import torch.nn as nn

import layers


class ModuleWrapper(nn.Module):
    def __init__(self):
        super(ModuleWrapper, self).__init__()

    def set_flag(self, flag_name, value):
        setattr(self, flag_name, value)
        for m in self.children():
            if hasattr(m, "set_flag"):
                m.set_flag(flag_name, value)

    def forward(self, x):
        for module in self.children():
            x = module(x)
            # if self.training:  ## Note: only for part_train
            #     if isinstance(module, layers.BBB_LRT_Linear):
            #         x = module(x)
            # else:
            #     x = module(x)

        kl = 0.0
        for module in self.modules():
            if hasattr(module, "kl_loss"):
                kl += module.kl_loss()
            # if self.training: ## Note: only for part_train
            #     if hasattr(module, "kl_loss") and isinstance(module, layers.BBB_LRT_Linear):
            #         kl += module.kl_loss()
            # elif hasattr(module, "kl_loss"):
            #     kl += module.kl_loss()

        return x, kl


class FlattenLayer(nn.Module):
    def __init__(self, num_features):
        super(FlattenLayer, self).__init__()
        self.num_features = num_features

    def forward(self, x):
        return x.view(-1, self.num_features)
