import sys

sys.path.append("..")

import torch
import torch.nn.functional as F
from torch.nn import Parameter
from metric import calculate_kl as KL_DIV
from layers.misc import ModuleWrapper


class BBBCov2dLRT(ModuleWrapper):
    """docstring for BBBCov2d"""

    def __init__(self, in_channels, out_channels, kernel_size,
                 stride=1, padding=0, dilation=1, bias=False, priors=None, clt=True, clt_num=10):
        super(BBBCov2dLRT, self).__init__()
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.kernel_size = kernel_size if isinstance(kernel_size, tuple) else (kernel_size, kernel_size)
        self.stride = stride
        self.padding = padding
        self.dilation = dilation
        self.grops = 1
        self.use_bias = bias
        self.clt = clt
        self.clt_num = clt_num
        self.clt_num_sqrt = torch.sqrt(torch.tensor(self.clt_num, requires_grad=False))
        self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

        if priors is None:
            priors = {
                "prior_mu": 0,
                "prior_sigma": 0,
                "posterior_mu_initial": (0, 0.1),
                "posterior_rho_initial": (-3, 0.1)
            }
        self.prior_mu = priors["prior_mu"]
        self.prior_sigma = priors["prior_sigma"]
        self.posterior_mu_initial = priors["posterior_mu_initial"]
        self.posterior_rho_initial = priors["posterior_rho_initial"]

        self.W_mu = Parameter(torch.empty((out_channels, in_channels, *self.kernel_size), device=self.device, dtype=torch.float32))
        self.W_rho = Parameter(torch.empty((out_channels, in_channels, *self.kernel_size), device=self.device, dtype=torch.float32))

        if self.use_bias:
            self.bias_mu = Parameter(torch.empty(out_channels, device=self.device))
            self.bias_rho = Parameter(torch.empty(out_channels, device=self.device))
        else:
            self.register_parameter("bias_mu", None)
            self.register_parameter("bias_rho", None)

        self.reset_parameter()

    def reset_parameter(self):
        self.W_mu.data.normal_(*self.posterior_mu_initial)
        self.W_rho.data.normal_(*self.posterior_rho_initial)

        if self.use_bias:
            self.bias_mu.data.normal_(*self.posterior_mu_initial)
            self.bias_rho.data.normal_(*self.posterior_rho_initial)

    def forward(self, inputs, sample=True):
        if self.training or sample:
            self.W_sigma = torch.log1p(torch.exp(self.W_rho))
            if self.clt:
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    bias_var = (self.bias_sigma ** 2) / (self.clt_num / 4)
                else:
                    self.bias_sigma = bias_var = None
                W_var = (self.W_sigma ** 2) / (self.clt_num / 4)
                act_mu = F.conv2d(inputs, self.W_mu, self.bias_mu, self.stride, self.padding, self.dilation, self.grops)
                act_var = 1e-32 + F.conv2d(inputs ** 2, W_var, bias_var, self.stride, self.padding, self.dilation, self.grops)
                act_std = torch.sqrt(act_var)
                eps = torch.zeros(act_mu.size()).to(self.device)
                for i in range(self.clt_num):
                    eps += torch.empty(act_mu.size()).bernoulli_(0.5).to(self.device)
                return act_mu + act_std * (eps - self.clt_num / 2)

            else:
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    bias_var = self.bias_sigma ** 2
                else:
                    self.bias_sigma = None
                    bias_var = None

                W_var = self.W_sigma ** 2
                inputs_2 = inputs ** 2

                act_mu = F.conv2d(inputs, self.W_mu, self.bias_mu, self.stride, self.padding, self.dilation, self.grops)

                act_var = 1e-32 + F.conv2d(
                    inputs_2, W_var, bias_var, self.stride, self.padding, self.dilation, self.grops)

                act_std = torch.sqrt(act_var)

                eps = torch.empty(act_mu.size()).normal_(0, 1).to(self.device)

                return act_mu + act_std * eps

    def kl_loss(self):
        kl = KL_DIV(self.W_mu, self.W_sigma, self.prior_mu, self.prior_sigma)
        if self.use_bias:
            kl += KL_DIV(self.bias_mu, self.bias_sigma, self.prior_mu, self.prior_sigma)
        return kl
