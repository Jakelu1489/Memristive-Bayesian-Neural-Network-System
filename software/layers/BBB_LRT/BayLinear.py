import sys

sys.path.append("..")

import torch
import torch.nn.functional as F
from torch.nn import Parameter
from layers.misc import ModuleWrapper
from metric import calculate_kl as KL_DIV


class BBBLinearLRT(ModuleWrapper):
    """docstring for BBBLinear"""

    def __init__(self, in_features, out_features, bias=True, priors=None,
                 clt=True, clt_num=10):
        super(BBBLinearLRT, self).__init__()
        self.in_features = in_features
        self.out_features = out_features
        self.use_bias = bias
        self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
        self.clt = clt
        self.clt_num = clt_num
        self.clt_num_sqrt = torch.sqrt(torch.tensor(clt_num, requires_grad=False))

        if priors is None:
            priors = {
                "prior_mu": 0,
                "prior_sigma": 0.1,
                "posterior_mu_initial": (0, 0.1),
                "posterior_rho_initial": (-5, 0.1)
            }
        self.prior_mu = priors["prior_mu"]
        self.prior_sigma = priors["prior_sigma"]
        self.posterior_mu_initial = priors["posterior_mu_initial"]
        self.posterior_rho_initial = priors["posterior_rho_initial"]

        self.W_mu = Parameter(torch.empty((out_features, in_features), device=self.device))
        self.W_rho = Parameter(torch.empty((out_features, in_features), device=self.device))

        if self.use_bias:
            self.bias_mu = Parameter(torch.empty((out_features), device=self.device))
            self.bias_rho = Parameter(torch.empty((out_features), device=self.device))
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
                act_mu = F.linear(inputs, self.W_mu, self.bias_mu)
                act_var = 1e-32 + F.linear(inputs ** 2, W_var, bias_var)
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
                    self.bias_sigma = bias_var = None

                act_mu = F.linear(inputs, self.W_mu, self.bias_mu)
                act_var = 1e-32 + F.linear(inputs ** 2, self.W_sigma ** 2, bias_var)
                act_std = torch.sqrt(act_var)

                eps = torch.empty(act_mu.size()).normal_(0, 1).to(self.device)
                return act_mu + act_std * eps

    def kl_loss(self):
        kl = KL_DIV(self.W_mu, self.W_sigma, self.prior_mu, self.prior_sigma)
        if self.use_bias:
            kl += KL_DIV(self.bias_mu, self.bias_sigma, self.prior_mu, self.prior_sigma)
        return kl
