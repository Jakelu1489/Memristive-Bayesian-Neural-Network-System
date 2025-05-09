import sys

sys.path.append("..")

import torch
import torch.nn.functional as F
from torch.nn import Parameter
from layers.misc import ModuleWrapper
from metric import calculate_kl as KL_DIV


class BBBLinear(ModuleWrapper):
    """docstring for BBBLinear"""

    def __init__(self, in_features, out_features, bias=False, priors=None,
                 clt=False, clt_num=25):
        super(BBBLinear, self).__init__()
        self.bias_sigma = 0
        self.W_sigma = 0
        self.in_features = in_features
        self.out_features = out_features
        self.use_bias = bias
        self.use_clt = clt
        self.clt_num = clt_num
        self.device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
        self.clt_num_sqrt = torch.sqrt(torch.tensor(self.clt_num))

        if priors is None:
            priors = {
                "prior_mu": 0,
                "prior_sigma": 0.1,
                "posterior_mu_initial": (0, 0.1),
                "posterior_rho_initial": (-3, 0.1)
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
            if self.use_clt:
                W_eps = torch.zeros(self.W_mu.size()).to(self.device)
                self.W_sigma = torch.log1p(torch.exp(self.W_rho))
                # using bernoulli random variable to generate binomial random variable
                # Y = X1 + X2 + X3 + ... + Xn, where xi is bernoulli random variable
                for i in range(self.clt_num):
                    # W_eps is Gaussian random variable N(clt_num / 2, clt_num / 4), given p = 0.5
                    # W_eps += torch.empty(self.W_mu.size()).bernoulli_(0.5).to(self.device)
                    W_eps += torch.bernoulli(torch.tensor(0.5)).to(self.device)
                # According to De Moivre - Laplace central limit theorem: when n is large enough,
                # the normal distribution may be used as an approximation to binomial distribution.

                # get the Gaussian weight: where p = 0.5, W_eps ~ N(clt_num / 2, clt_num / 4)
                # N(mu, sigma**2) = mu - sqrt(clt_num) * sigma + sigma * (2 / sqrt(clt_num)) * W_eps
                weight = self.W_mu - (self.W_sigma * self.clt_num_sqrt) + self.W_sigma * (2 / self.clt_num_sqrt) * W_eps

                if self.use_bias:
                    bias_eps = torch.zeros(self.bias_mu.size()).to(self.device)
                    for i in range(self.clt_num):
                        # the generation process is the same as the Gaussian weight
                        bias_eps += torch.empty(self.bias_mu.size()).bernoulli_(0.5).to(self.device)
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    bias = self.bias_mu - (self.clt_num_sqrt * self.bias_sigma) + self.bias_sigma * (2 / self.clt_num_sqrt) * bias_eps
                else:
                    bias = None
            else:
                W_eps = torch.empty(self.W_mu.size()).normal_(0, 1).to(self.device)
                self.W_sigma = torch.log1p(torch.exp(self.W_rho))
                weight = self.W_mu + W_eps * self.W_sigma

                if self.use_bias:
                    bias_eps = torch.empty(self.bias_mu.size()).normal_(0, 1).to(self.device)
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    bias = self.bias_mu + self.bias_sigma * bias_eps
                else:
                    bias = None
        else:
            weight = self.W_mu
            bias = self.bias_mu if self.use_bias else None

        return F.linear(inputs, weight, bias)

    def kl_loss(self):
        kl = KL_DIV(self.W_mu, self.W_sigma, self.prior_mu, self.prior_sigma)
        if self.use_bias:
            kl += KL_DIV(self.bias_mu, self.bias_sigma, self.prior_mu, self.prior_sigma)
        return kl
