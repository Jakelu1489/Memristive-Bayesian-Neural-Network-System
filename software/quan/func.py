import torch
import torch.nn as nn
import torch.nn.functional as F
from layers.BBB.BayConv import BBBCov2d
from layers.BBB.BayLinear import BBBLinear
from layers.BBB_LRT.BayConv import BBBCov2dLRT
from layers.BBB_LRT.BayLinear import BBBLinearLRT
from metric import calculate_kl as KL_DIV
from scipy.stats import lognorm, norm
import numpy as np


class QuanBayConv2d(BBBCov2d):
    def __init__(self, m: BBBCov2d, quan_wu_fn=None, quan_sigma_fn=None, quan_a_fn=None):
        super(QuanBayConv2d, self).__init__(m.in_channels, m.out_channels, m.kernel_size, stride=m.stride,
                                            padding=m.padding, dilation=m.dilation,
                                            bias=True if m.use_bias is True else False, clt=m.use_clt,
                                            clt_num=m.clt_num)
        self.quan_wu_fn = quan_wu_fn
        self.quan_a_fn = quan_a_fn
        self.quan_sigma_fn = quan_sigma_fn
        self.use_clt = m.use_clt
        self.clt_num = m.clt_num
        self.clt_num_sqrt = m.clt_num_sqrt
        self.device = m.device
        self.use_bias = m.use_bias
        self.prior_mu = m.prior_mu
        self.prior_sigma = m.prior_sigma
        self.s = np.array(
            [0.54147825, 0.49174054, 0.49825244, 0.50733797, 0.52088885, 0.51254288, 0.52669085, 0.57965879])
        self.loc = np.array([-0.12383648, -0.17164378, -0.12264526, -0.0947662, -0.06672813, -0.05594625, -0.03541853,
                             -0.00165454])
        self.scale = np.array(
            [0.67767643, 0.75957629, 0.68150852, 0.65658999, 0.61375458, 0.58011671, 0.53072312, 0.44741314])
        self.noise = False

        if self.use_clt:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu - torch.log1p(torch.exp(m.W_rho)) * m.clt_num_sqrt)
            self.quan_sigma_fn.init_from(torch.log1p(torch.exp(m.W_rho)) * (2 / m.clt_num_sqrt))
            if self.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())
        else:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu)
            self.quan_sigma_fn.init_from(torch.log1p(torch.exp(m.W_rho)))
            if m.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())

    def forward(self, inputs, sample=True):
        self.W_sigma = torch.log1p(torch.exp(self.W_rho))
        if self.training or sample:
            if self.use_clt:
                quantized_mu = self.quan_wu_fn(self.W_mu - self.W_sigma * self.clt_num_sqrt)
                quantized_sigma = self.quan_sigma_fn(self.W_sigma * (2 / self.clt_num_sqrt))
                if self.noise:
                    quantized_mu += self.mu_mapping(quantized_mu)
                    quantized_sigma += self.sigma_mapping(quantized_sigma)
                    # quantized_mu += torch.normal(0, 1, size=quantized_mu.shape)
                    # quantized_sigma += torch.normal(0, 1, size=quantized_sigma.shape)
                quantized_act = self.quan_a_fn(inputs)
                W_eps = torch.zeros(self.W_mu.size()).to(self.device)
                for i in range(self.clt_num):
                    W_eps += torch.empty(self.W_mu.size()).bernoulli_(0.5).to(self.device)
                weight = quantized_mu + quantized_sigma * W_eps
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu - self.bias_sigma * self.clt_num_sqrt)
                    quantized_bias_sigma = self.quan_sigma_fn(self.bias_sigma * (2 / self.clt_num_sqrt))
                    bias_eps = torch.zeros(self.bias_mu.size()).to(self.device)
                    for i in range(self.clt_num):
                        bias_eps += torch.empty(self.bias_mu.size()).bernoulli_(0.5).to(self.device)
                    bias = quantized_bias_mu + quantized_bias_sigma * bias_eps
                else:
                    bias = None
                return F.conv2d(quantized_act, weight, bias, self.stride, self.padding, self.dilation, self.grops)
            else:
                quantized_mu = self.quan_wu_fn(self.W_mu)
                quantized_sigma = self.quan_sigma_fn(self.W_sigma)
                quantized_act = self.quan_a_fn(inputs)
                W_eps = torch.empty(self.W_mu.size()).normal_(0, 1).to(self.device)
                weight = quantized_mu + quantized_sigma * W_eps
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu)
                    quantized_bias_sigma = self.quan_sigma_fn(self.bias_sigma)
                    bias_eps = torch.zeros(self.bias_mu.size()).normal_(0, 1).to(self.device)
                    bias = quantized_bias_mu + quantized_bias_sigma * bias_eps
                else:
                    bias = None
                return F.conv2d(quantized_act, weight, bias, self.stride, self.padding, self.dilation, self.grops)

    def mu_mapping(self, mu):
        s_mu_temp = self.quan_wu_fn.s.detach().clone().cpu()
        mu_temp = mu.detach().clone().cpu() / s_mu_temp
        mu_pos = np.where(mu_temp >= 0, mu_temp, 0).astype(np.int32)
        mu_neg = np.where(mu_temp < 0, torch.abs(mu_temp), 0).astype(np.int32)
        s_temp_pos = self.s[mu_pos]
        s_temp_neg = self.s[mu_neg]
        loc_temp_pos = self.loc[mu_pos]
        loc_temp_neg = self.loc[mu_neg]
        scale_temp_pos = self.scale[mu_pos]
        scale_temp_neg = self.scale[mu_neg]
        noise_temp = np.zeros_like(mu_temp)
        noise_temp_pos = np.abs(lognorm.rvs(s=s_temp_pos, loc=loc_temp_pos, scale=scale_temp_pos))
        noise_temp_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_temp_pos * norm.rvs(0, 1, size=mu.shape) - noise_temp_neg * norm.rvs(0, 1,
                                                                                                  size=mu.shape)) / 20
        noise_temp *= s_mu_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def sigma_mapping(self, sigma):
        s_sigma_temp = self.quan_sigma_fn.s.detach().clone().cpu()
        sigma_temp = sigma.detach().clone().cpu() / s_sigma_temp
        sigma_temp = np.array(sigma_temp).astype(np.int32)
        sigma_neg = np.zeros_like(sigma_temp).astype(np.int32)
        s_temp = self.s[sigma_temp]
        loc_temp = self.loc[sigma_temp]
        scale_temp = self.scale[sigma_temp]
        s_temp_neg = self.s[sigma_neg]
        loc_temp_neg = self.loc[sigma_neg]
        scale_temp_neg = self.scale[sigma_neg]
        # noise_temp = np.array(torch.zeros_like(sigma))
        noise_temp = np.zeros_like(sigma_temp).astype(np.float32)
        noise_sig_temp = np.abs(lognorm.rvs(s=s_temp, loc=loc_temp, scale=scale_temp))
        noise_sig_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_sig_temp * norm.rvs(0, 1, size=sigma.shape) - noise_sig_neg * norm.rvs(0, 1,
                                                                                                    size=sigma.shape)) / 20
        noise_temp *= s_sigma_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def kl_loss(self):
        kl = KL_DIV(self.prior_mu, self.prior_sigma, self.W_mu, self.W_sigma)
        if self.use_bias:
            kl += KL_DIV(self.prior_mu, self.prior_sigma, self.bias_mu, self.bias_sigma)
        return kl


class QuanBayLinear(BBBLinear):
    def __init__(self, m: BBBLinear, quan_wu_fn=None, quan_sigma_fn=None, quan_a_fn=None):
        super(QuanBayLinear, self).__init__(m.in_features, m.out_features,
                                            bias=True if m.use_bias is True else False,
                                            clt=m.use_clt, clt_num=m.clt_num)
        self.quan_wu_fn = quan_wu_fn
        self.quan_a_fn = quan_a_fn
        self.quan_sigma_fn = quan_sigma_fn
        self.use_clt = m.use_clt
        self.clt_num = m.clt_num
        self.clt_num_sqrt = m.clt_num_sqrt
        self.device = m.device
        self.use_bias = m.use_bias
        self.prior_mu = m.prior_mu
        self.prior_sigma = m.prior_sigma
        self.s = np.array(
            [0.54147825, 0.49174054, 0.49825244, 0.50733797, 0.52088885, 0.51254288, 0.52669085, 0.57965879])
        self.loc = np.array([-0.12383648, -0.17164378, -0.12264526, -0.0947662, -0.06672813, -0.05594625, -0.03541853,
                             -0.00165454])
        self.scale = np.array(
            [0.67767643, 0.75957629, 0.68150852, 0.65658999, 0.61375458, 0.58011671, 0.53072312, 0.44741314])
        self.noise = False

        if self.use_clt:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu - torch.log1p(torch.exp(m.W_rho)) * m.clt_num_sqrt)
            self.quan_sigma_fn.init_from(torch.log1p(torch.exp(m.W_rho)) * (2 / m.clt_num_sqrt))
            if self.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())
        else:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu)
            self.quan_sigma_fn.init_from(torch.log1p(torch.exp(m.W_rho)))
            if m.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())

    def forward(self, inputs, sample=True):
        self.W_sigma = torch.log1p(torch.exp(self.W_rho))
        if self.training or sample:
            if self.use_clt:
                quantized_mu = self.quan_wu_fn(self.W_mu - self.W_sigma * self.clt_num_sqrt)
                quantized_sigma = self.quan_sigma_fn(self.W_sigma * (2 / self.clt_num_sqrt))
                if self.noise:
                    quantized_mu += self.mu_mapping(quantized_mu)
                    quantized_sigma += self.sigma_mapping(quantized_sigma)
                    # quantized_mu += torch.normal(0, 1, size=quantized_mu.shape)
                    # quantized_sigma += torch.abs(torch.normal(0, 1, size=quantized_sigma.shape))
                quantized_act = self.quan_a_fn(inputs)
                W_eps = torch.zeros(self.W_mu.size()).to(self.device)
                for i in range(self.clt_num):
                    W_eps += torch.empty(self.W_mu.size()).bernoulli_(0.5).to(self.device)
                weight = quantized_mu + quantized_sigma * W_eps
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu - self.bias_sigma * self.clt_num_sqrt)
                    quantized_bias_sigma = self.quan_sigma_fn(self.bias_sigma * (2 / self.clt_num_sqrt))
                    bias_eps = torch.zeros(self.bias_mu.size()).to(self.device)
                    for i in range(self.clt_num):
                        bias_eps += torch.empty(self.bias_mu.size()).bernoulli_(0.5).to(self.device)
                    bias = quantized_bias_mu + quantized_bias_sigma * bias_eps
                else:
                    bias = None
                return F.linear(quantized_act, weight, bias)
            else:
                quantized_mu = self.quan_wu_fn(self.W_mu)
                quantized_sigma = self.quan_sigma_fn(self.W_sigma)
                quantized_act = self.quan_a_fn(inputs)
                W_eps = torch.empty(self.W_mu.size()).normal_(0, 1).to(self.device)
                weight = quantized_mu + quantized_sigma * W_eps
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu)
                    quantized_bias_sigma = self.quan_sigma_fn(self.bias_sigma)
                    bias_eps = torch.zeros(self.bias_mu.size()).normal_(0, 1).to(self.device)
                    bias = quantized_bias_mu + quantized_bias_sigma * bias_eps
                else:
                    bias = None
                return F.linear(quantized_act, weight, bias)

    def mu_mapping(self, mu):
        s_mu_temp = self.quan_wu_fn.s.detach().clone().cpu()
        mu_temp = mu.detach().clone().cpu() / s_mu_temp
        mu_pos = np.where(mu_temp >= 0, mu_temp, 0).astype(np.int32)
        mu_neg = np.where(mu_temp < 0, torch.abs(mu_temp), 0).astype(np.int32)
        s_temp_pos = self.s[mu_pos]
        s_temp_neg = self.s[mu_neg]
        loc_temp_pos = self.loc[mu_pos]
        loc_temp_neg = self.loc[mu_neg]
        scale_temp_pos = self.scale[mu_pos]
        scale_temp_neg = self.scale[mu_neg]
        # noise_temp = np.array(torch.zeros_like(mu))
        noise_temp = np.zeros_like(mu_temp)
        noise_temp_pos = np.abs(lognorm.rvs(s=s_temp_pos, loc=loc_temp_pos, scale=scale_temp_pos))
        noise_temp_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_temp_pos * norm.rvs(0, 1, size=mu.shape) - noise_temp_neg * norm.rvs(0, 1,
                                                                                                  size=mu.shape)) / 20
        noise_temp *= s_mu_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def sigma_mapping(self, sigma):
        s_sigma_temp = self.quan_sigma_fn.s.detach().clone().cpu()
        sigma_temp = sigma.detach().clone().cpu() / s_sigma_temp
        sigma_temp = np.array(sigma_temp).astype(np.int32)
        sigma_neg = np.zeros_like(sigma_temp).astype(np.int32)
        s_temp = self.s[sigma_temp]
        loc_temp = self.loc[sigma_temp]
        scale_temp = self.scale[sigma_temp]
        s_temp_neg = self.s[sigma_neg]
        loc_temp_neg = self.loc[sigma_neg]
        scale_temp_neg = self.scale[sigma_neg]
        # noise_temp = np.array(torch.zeros_like(sigma))
        noise_temp = np.zeros_like(sigma_temp).astype(np.float32)
        noise_sig_temp = np.abs(lognorm.rvs(s=s_temp, loc=loc_temp, scale=scale_temp))
        noise_sig_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_sig_temp * norm.rvs(0, 1, size=sigma.shape) - noise_sig_neg * norm.rvs(0, 1,
                                                                                                    size=sigma.shape)) / 20
        noise_temp *= s_sigma_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def kl_loss(self):
        kl = KL_DIV(self.prior_mu, self.prior_sigma, self.W_mu, self.W_sigma)
        if self.use_bias:
            kl += KL_DIV(self.prior_mu, self.prior_sigma, self.bias_mu, self.bias_sigma)
        return kl


class QuanBayConv2dLRT(BBBCov2dLRT):
    def __init__(self, m: BBBCov2dLRT, quan_wu_fn=None, quan_sigma_fn=None, quan_a_fn=None):
        super(QuanBayConv2dLRT, self).__init__(m.in_channels, m.out_channels, m.kernel_size, stride=m.stride,
                                               padding=m.padding, dilation=m.dilation,
                                               bias=True if m.use_bias is True else False, clt=m.clt,
                                               clt_num=m.clt_num)
        self.quan_wu_fn = quan_wu_fn
        self.quan_sigma_fn = quan_sigma_fn
        self.quan_a_fn = quan_a_fn
        self.use_clt = m.clt
        self.clt_num = m.clt_num
        self.clt_num_sqrt = m.clt_num_sqrt
        self.device = m.device
        self.use_bias = m.use_bias
        self.prior_mu = m.prior_mu
        self.prior_sigma = m.prior_sigma
        self.s = np.array(
            [0.54147825, 0.49174054, 0.49825244, 0.50733797, 0.52088885, 0.51254288, 0.52669085, 0.57965879])
        self.loc = np.array([-0.12383648, -0.17164378, -0.12264526, -0.0947662, -0.06672813,
                             -0.05594625, -0.03541853, -0.00165454])
        self.scale = np.array(
            [0.67767643, 0.75957629, 0.68150852, 0.65658999, 0.61375458, 0.58011671, 0.53072312, 0.44741314])
        self.noise = True

        if self.use_clt:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu)
            self.quan_sigma_fn.init_from((torch.log1p(torch.exp(m.W_rho)) ** 2) / (self.clt_num / 4))
            if self.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())
        else:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu)
            self.quan_sigma_fn.init_from(torch.log1p(torch.exp(m.W_rho)) ** 2)
            if self.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())

    def forward(self, inputs, sample=True):
        self.W_sigma = torch.log1p(torch.exp(self.W_rho))
        if self.training or sample:
            if self.use_clt:
                quantized_mu = self.quan_wu_fn(self.W_mu)
                quantized_var = self.quan_sigma_fn((self.W_sigma ** 2) / (self.clt_num / 4))
                quantized_act = self.quan_a_fn(inputs).to(self.device)
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu)
                    quantized_bias_var = self.quan_sigma_fn((self.bias_sigma ** 2) / (self.clt_num / 4))
                else:
                    quantized_bias_mu = None
                    quantized_bias_var = None
                if self.noise:
                    quantized_mu += self.mu_mapping(quantized_mu)
                    quantized_var += self.var_mapping(quantized_var)
                    quantized_var = torch.abs(quantized_var)
                    if self.use_bias:
                        quantized_bias_mu += self.mu_mapping(quantized_bias_mu)
                        quantized_bias_var += self.var_mapping(quantized_bias_var)
                act_mu = F.conv2d(quantized_act, quantized_mu, quantized_bias_mu, self.stride, self.padding,
                                  self.dilation, self.grops)
                if self.noise:
                    act_mu += act_mu * 0.15 * torch.normal(0, 1, size=act_mu.size()).to(self.device)
                act_var = 1e-32 + F.conv2d(quantized_act ** 2, quantized_var, quantized_bias_var, self.stride,
                                           self.padding,
                                           self.dilation, self.grops)
                if self.noise:
                    act_var += act_var * 0.15 * torch.normal(0, 1, size=act_var.size()).to(self.device)
                act_std = torch.sqrt(act_var)
                eps = torch.zeros(act_mu.size()).to(self.device)
                for i in range(self.clt_num):
                    eps += torch.empty(act_mu.size()).bernoulli_(0.5).to(self.device)
                return act_mu + act_std * (eps - self.clt_num / 2)
            else:
                quantized_mu = self.quan_wu_fn(self.W_mu)
                quantized_var = self.quan_sigma_fn(self.W_sigma ** 2)
                if self.noise:
                    pass
                quantized_act = self.quan_a_fn(inputs)
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu)
                    quantized_bias_var = self.quan_sigma_fn(self.bias_sigma ** 2)
                else:
                    quantized_bias_mu = None
                    quantized_bias_var = None
                if self.noise:
                    quantized_mu += self.mu_mapping(quantized_mu)
                    quantized_var += self.var_mapping(quantized_var)
                    if (quantized_var < 0).any():
                        raise ValueError("Conv var is negative")
                    if self.use_bias:
                        quantized_bias_mu += self.mu_mapping(quantized_bias_mu)
                        quantized_bias_var += self.var_mapping(quantized_bias_var)
                act_mu = F.conv2d(quantized_act, quantized_mu, quantized_bias_mu, self.stride, self.padding,
                                  self.dilation, self.grops)
                act_var = 1e-32 + F.conv2d(quantized_act ** 2, quantized_var, quantized_bias_var, self.stride,
                                           self.padding,
                                           self.dilation, self.grops)
                act_std = torch.sqrt(act_var)
                eps = torch.empty(act_mu.size()).normal_(0, 1).to(self.device)
                return act_mu + act_std * eps

    def mu_mapping(self, mu):
        s_mu_temp = self.quan_wu_fn.s.detach().clone().cpu()
        mu_temp = mu.detach().clone().cpu() / s_mu_temp
        mu_pos = np.where(mu_temp >= 0, mu_temp, 0).astype(np.int32)
        mu_neg = np.where(mu_temp < 0, torch.abs(mu_temp), 0).astype(np.int32)
        s_temp_pos = self.s[mu_pos]
        s_temp_neg = self.s[mu_neg]
        loc_temp_pos = self.loc[mu_pos]
        loc_temp_neg = self.loc[mu_neg]
        scale_temp_pos = self.scale[mu_pos]
        scale_temp_neg = self.scale[mu_neg]
        noise_temp = np.zeros_like(mu_temp)
        noise_temp_pos = np.abs(lognorm.rvs(s=s_temp_pos, loc=loc_temp_pos, scale=scale_temp_pos))
        noise_temp_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_temp_pos * norm.rvs(0, 1, size=mu.shape) - noise_temp_neg * norm.rvs(0, 1,
                                                                                                  size=mu.shape)) / 20
        noise_temp *= s_mu_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def var_mapping(self, sigma):
        s_sigma_temp = self.quan_sigma_fn.s.detach().clone().cpu()
        sigma_temp = sigma.detach().clone().cpu() / s_sigma_temp
        sigma_temp = np.array(sigma_temp).astype(np.int32)
        sigma_neg = np.zeros_like(sigma_temp).astype(np.int32)
        s_temp = self.s[sigma_temp]
        loc_temp = self.loc[sigma_temp]
        scale_temp = self.scale[sigma_temp]
        s_temp_neg = self.s[sigma_neg]
        loc_temp_neg = self.loc[sigma_neg]
        scale_temp_neg = self.scale[sigma_neg]
        # noise_temp = np.array(torch.zeros_like(sigma))
        noise_temp = np.zeros_like(sigma_temp).astype(np.float32)
        noise_sig_temp = np.abs(lognorm.rvs(s=s_temp, loc=loc_temp, scale=scale_temp))
        noise_sig_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_sig_temp * norm.rvs(0, 1, size=sigma.shape) - noise_sig_neg * norm.rvs(0, 1,
                                                                                                    size=sigma.shape)) / 20
        # noise_temp = np.abs(noise_temp[sigma_temp==0])
        # noise_temp[sigma_temp == 0] = np.abs(noise_temp[sigma_temp == 0])
        noise_temp *= s_sigma_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def kl_loss(self):
        kl = KL_DIV(self.prior_mu, self.prior_sigma, self.W_mu, self.W_sigma)
        if self.use_bias:
            kl += KL_DIV(self.prior_mu, self.prior_sigma, self.bias_mu, self.bias_sigma)
        return kl


class QuanBayLinearLRT(BBBLinearLRT):
    def __init__(self, m: BBBLinearLRT, quan_wu_fn=None, quan_sigma_fn=None, quan_a_fn=None):
        super(QuanBayLinearLRT, self).__init__(m.in_features, m.out_features,
                                               bias=True if m.use_bias is True else False, clt=m.clt, clt_num=m.clt_num)
        self.quan_wu_fn = quan_wu_fn
        self.quan_a_fn = quan_a_fn
        self.quan_sigma_fn = quan_sigma_fn
        self.use_clt = m.clt
        self.clt_num = m.clt_num
        self.clt_num_sqrt = m.clt_num_sqrt
        self.device = m.device
        self.use_bias = m.use_bias
        self.prior_mu = m.prior_mu
        self.prior_sigma = m.prior_sigma
        self.s = np.array(
            [0.54147825, 0.49174054, 0.49825244, 0.50733797, 0.52088885, 0.51254288, 0.52669085, 0.57965879])
        self.loc = np.array([-0.12383648, -0.17164378, -0.12264526, -0.0947662, -0.06672813, -0.05594625, -0.03541853,
                             -0.00165454])
        self.scale = np.array(
            [0.67767643, 0.75957629, 0.68150852, 0.65658999, 0.61375458, 0.58011671, 0.53072312, 0.44741314])
        self.noise = True

        if self.use_clt:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu)
            self.quan_sigma_fn.init_from((torch.log1p(torch.exp(m.W_rho)) ** 2 / (self.clt_num / 4)))
            if self.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())
        else:
            self.W_mu = torch.nn.Parameter(m.W_mu.detach())
            self.W_rho = torch.nn.Parameter(m.W_rho.detach())
            self.quan_wu_fn.init_from(m.W_mu)
            self.quan_sigma_fn.init_from(torch.log1p(torch.exp(m.W_rho)) ** 2)
            if m.use_bias is True:
                self.bias_mu = torch.nn.Parameter(m.bias_mu.detach())
                self.bias_rho = torch.nn.Parameter(m.bias_rho.detach())

    def forward(self, inputs, sample=True):
        self.W_sigma = torch.log1p(torch.exp(self.W_rho))
        if self.training or sample:
            if self.use_clt:
                quantized_mu = self.quan_wu_fn(self.W_mu)
                quantized_var = self.quan_sigma_fn((self.W_sigma ** 2) / (self.clt_num / 4))
                quantized_act = self.quan_a_fn(inputs)
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu)
                    quantized_bias_var = self.quan_sigma_fn(self.bias_sigma ** 2 / (self.clt_num / 4))
                else:
                    quantized_bias_mu = None
                    quantized_bias_var = None
                if self.noise:
                    quantized_mu += self.mu_mapping(quantized_mu)
                    quantized_var += self.var_mapping(quantized_var)
                    quantized_var = torch.abs(quantized_var)
                    if self.use_bias:
                        quantized_bias_mu += self.mu_mapping(quantized_bias_mu)
                        quantized_bias_var += self.var_mapping(quantized_bias_var)
                act_mu = F.linear(quantized_act, quantized_mu, quantized_bias_mu)
                if self.noise:
                    act_mu += act_mu * 0.15 * torch.normal(0, 1, size=act_mu.size()).to(self.device)
                act_var = 1e-32 + F.linear(quantized_act ** 2, quantized_var, quantized_bias_var)
                if self.noise:
                    act_var += act_var * 0.15 * torch.normal(0, 1, size=act_var.size()).to(self.device)
                act_std = torch.sqrt(act_var)
                eps = torch.zeros(act_mu.size()).to(self.device)
                for i in range(self.clt_num):
                    eps += torch.empty(act_mu.size()).bernoulli_(0.5).to(self.device)
                return act_mu + act_std * (eps - self.clt_num / 2)
            else:
                quantized_mu = self.quan_wu_fn(self.W_mu)
                quantized_var = self.quan_sigma_fn(self.W_sigma ** 2)
                quantized_act = self.quan_a_fn(inputs)
                if self.use_bias:
                    self.bias_sigma = torch.log1p(torch.exp(self.bias_rho))
                    quantized_bias_mu = self.quan_wu_fn(self.bias_mu)
                    quantized_bias_var = self.quan_sigma_fn(self.bias_sigma ** 2)
                else:
                    quantized_bias_mu = None
                    quantized_bias_var = None
                if self.noise:
                    quantized_mu += self.mu_mapping(quantized_mu)
                    quantized_var += self.var_mapping(quantized_var)
                    if self.use_bias:
                        quantized_bias_mu += self.mu_mapping(quantized_bias_mu)
                        quantized_bias_var += self.var_mapping(quantized_bias_var)
                act_mu = F.linear(quantized_act, quantized_mu, quantized_bias_mu)
                act_var = 1e-32 + F.linear(quantized_act ** 2, quantized_var, quantized_bias_var)
                act_std = torch.sqrt(act_var)
                eps = torch.empty(act_mu.size()).normal_(0, 1).to(self.device)
                return act_mu + act_std * eps

    def mu_mapping(self, mu):
        s_mu_temp = self.quan_wu_fn.s.detach().clone().cpu()
        mu_temp = mu.detach().clone().cpu() / s_mu_temp
        mu_pos = np.where(mu_temp >= 0, mu_temp, 0).astype(np.int32)
        mu_neg = np.where(mu_temp < 0, torch.abs(mu_temp), 0).astype(np.int32)
        s_temp_pos = self.s[mu_pos]
        s_temp_neg = self.s[mu_neg]
        loc_temp_pos = self.loc[mu_pos]
        loc_temp_neg = self.loc[mu_neg]
        scale_temp_pos = self.scale[mu_pos]
        scale_temp_neg = self.scale[mu_neg]
        noise_temp = np.zeros_like(mu_temp)
        noise_temp_pos = np.abs(lognorm.rvs(s=s_temp_pos, loc=loc_temp_pos, scale=scale_temp_pos))
        noise_temp_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_temp_pos * norm.rvs(0, 1, size=mu.shape) - noise_temp_neg * norm.rvs(0, 1,
                                                                                                  size=mu.shape)) / 20
        noise_temp *= s_mu_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def var_mapping(self, sigma):
        s_sigma_temp = self.quan_sigma_fn.s.detach().clone().cpu()
        sigma_temp = sigma.detach().clone().cpu() / s_sigma_temp
        sigma_temp = np.array(sigma_temp).astype(np.int32)
        sigma_neg = np.zeros_like(sigma_temp).astype(np.int32)
        s_temp = self.s[sigma_temp]
        loc_temp = self.loc[sigma_temp]
        scale_temp = self.scale[sigma_temp]
        s_temp_neg = self.s[sigma_neg]
        loc_temp_neg = self.loc[sigma_neg]
        scale_temp_neg = self.scale[sigma_neg]
        # noise_temp = np.array(torch.zeros_like(sigma))
        noise_temp = np.zeros_like(sigma_temp).astype(np.float32)
        noise_sig_temp = np.abs(lognorm.rvs(s=s_temp, loc=loc_temp, scale=scale_temp))
        noise_sig_neg = np.abs(lognorm.rvs(s=s_temp_neg, loc=loc_temp_neg, scale=scale_temp_neg))
        noise_temp += (noise_sig_temp * norm.rvs(0, 1, size=sigma.shape) - noise_sig_neg * norm.rvs(0, 1,
                                                                                                    size=sigma.shape)) / 20
        # noise_temp[sigma_temp == 0] = np.abs(noise_temp[sigma_temp == 0])
        noise_temp *= s_sigma_temp.numpy()
        return torch.tensor(noise_temp).to(self.device)

    def kl_loss(self):
        kl = KL_DIV(self.prior_mu, self.prior_sigma, self.W_mu, self.W_sigma)
        if self.use_bias:
            kl += KL_DIV(self.prior_mu, self.prior_sigma, self.bias_mu, self.bias_sigma)
        return kl


class QuanConv2d(torch.nn.Conv2d):
    def __init__(self, m: torch.nn.Conv2d, quan_w_fn=None, quan_a_fn=None):
        assert type(m) == torch.nn.Conv2d
        super(QuanConv2d, self).__init__(m.in_channels, m.out_channels, m.kernel_size, padding=m.padding,
                                         bias=True if m.bias is True else False)
        self.quan_w_fn = quan_w_fn
        self.quan_a_fn = quan_a_fn

        self.weight = torch.nn.Parameter(m.weight.detach())
        self.quan_w_fn.init_from(m.weight)
        if m.bias is True:
            self.bias = torch.nn.Parameter(m.bias.detach)

    def forward(self, inputs):
        quantized_weight = self.quan_w_fn(self.weight)
        quantized_act = self.quan_a_fn(inputs)
        return self._conv_forward(quantized_act, quantized_weight, self.bias)


class QuanLinear(torch.nn.Linear):
    def __init__(self, m: torch.nn.Linear, quan_w_fn, quan_a_fn):
        assert type(m) == torch.nn.Linear
        super(QuanLinear, self).__init__(m.in_features, m.out_features, bias=True if m.bias is True else False)
        self.quan_w_fn = quan_w_fn
        self.quan_a_fn = quan_a_fn

        self.weight = torch.nn.Parameter(m.weight.detach())
        self.quan_w_fn.init_from(m.weight)
        if m.bias is True:
            self.bias = torch.nn.Parameter(m.bias.detach())

    def forward(self, inputs):
        quantized_weight = self.quan_w_fn(self.weight)
        quantized_act = self.quan_a_fn(inputs)
        return torch.nn.functional.linear(quantized_act, quantized_weight, self.bias)


QuanmoduleMapping = {
    BBBCov2d: QuanBayConv2d,
    BBBLinear: QuanBayLinear,
    BBBCov2dLRT: QuanBayConv2dLRT,
    BBBLinearLRT: QuanBayLinearLRT,
    torch.nn.Conv2d: QuanConv2d,
    torch.nn.Linear: QuanLinear
}
