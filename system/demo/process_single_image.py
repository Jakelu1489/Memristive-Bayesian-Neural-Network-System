import copy
import os

import torch
import numpy as np
from rram_api import Control
from torch.nn import functional as F
import time

from collections import defaultdict

np.random.seed(int(time.time()))


def logmeanexp(x, dim=None, keepdim=False):
    if dim is None:
        x, dim = x.view(-1), 0

    x_max, _ = torch.max(x, dim, keepdim=True)
    x = x_max + torch.log(torch.mean(torch.exp(x - x_max), dim, keepdim=True))

    return x if keepdim else x.squeeze(dim)


def acc(output, targets):
    y = np.mean(output.numpy().argmax(axis=1) == targets.data.numpy())
    return y


class Process:
    def __init__(self, weight_path, clt_num=10):
        self.weight_path = weight_path
        self.clt_num = clt_num

        self.named_parameters = torch.load(weight_path, map_location='cpu')
        self.params_dict = {}
        self.quan_params_dict = {}
        self.map_quan_params_dict = {}
        self.RRAM_params_dict = {}

        self.get_model_parameters()
        self.weight_trans()
        self.weight_quan()

        self.weight_flatten()
        self.p3 = torch.nn.MaxPool2d(3)
        self.p2 = torch.nn.MaxPool2d(2)

        self.mu_row = [[range(1, 10)], [range(10, 50), range(0, 32)], [range(0, 64), range(0, 64)]]
        self.mu_col = [[list(range(16, 26)) + list(range(27, 33))], [range(33, 49), range(62, 78)], [range(78, 98), range(98, 118)]]

        self.var_row = [[range(0, 9)], [range(9, 49), range(0, 32)], [range(0, 64), range(0, 64)]]
        self.var_col = [[range(0, 8)], [range(0, 8), range(16, 24)], [range(54, 64), range(26, 36)]]

        self.com_row, self.com_col = range(64), range(36, 46)
        self.com_g = 40

        self.weight_mapping(self.com_g, self.com_g + 140)

        self.buffer = defaultdict()

    def get_model_parameters(self):
        params = list(self.named_parameters.items())
        for j in range(params.__len__()):
            if "W_mu" in params[j][0]:
                self.params_dict[params[j][0]] = params[j][1].cpu().detach().numpy().squeeze()
            elif "W_rho" in params[j][0]:
                self.params_dict[params[j][0][:-3] + "sigma"] = torch.log1p(
                    torch.exp(params[j][1])).cpu().detach().numpy().squeeze()
            elif "quan_wu_fn.s" in params[j][0]:
                self.params_dict[params[j][0]] = params[j][1].cpu().detach().numpy().squeeze()
            elif "quan_sigma_fn.s" in params[j][0]:
                self.params_dict[params[j][0]] = params[j][1].cpu().detach().numpy().squeeze()
            elif "quan_a_fn.s" in params[j][0]:
                self.params_dict[params[j][0]] = params[j][1].cpu().detach().numpy().squeeze()
            else:
                raise ValueError(f"The model only support mu, rho, s for now!!!(Error key: {params[j][0]})")

    def weight_trans(self):
        for key in self.params_dict.keys():
            if "W_sigma" in key:
                self.params_dict[key] = self.params_dict[key] ** 2 / (self.clt_num / 4)

    def weight_quan(self):
        for key in self.params_dict.keys():
            if "W_mu" in key:
                w_mu_s = self.params_dict[key[:-4] + "quan_wu_fn.s"]
                self.quan_params_dict["quan_" + key] = self.quantizer(bit=4, scale=w_mu_s, w=self.params_dict[key])
            elif "W_sigma" in key:
                w_sigma_s = self.params_dict[key[:-7] + "quan_sigma_fn.s"]

                self.quan_params_dict["quan_" + key] = np.abs(
                    self.quantizer(bit=3, scale=w_sigma_s, w=self.params_dict[key],
                                   all_positive=True, symmetric=False))
                self.params_dict[key[:-7] + "quan_sigma_fn.s"] = np.abs(w_sigma_s)

    def quantizer(self, bit, scale, w, all_positive=False, symmetric=True, per_channel=False):
        if all_positive:
            assert not symmetric, "Positive quantization cannot be symmetric"
            thd_neg = 0
            thd_pos = 2 ** bit - 1
        else:
            if symmetric:
                thd_pos = 2 ** (bit - 1) - 1
                thd_neg = -2 ** (bit - 1) + 1
            else:
                thd_pos = 2 ** (bit - 1) - 1
                thd_neg = -2 ** (bit - 1)
        x = torch.tensor(w) / scale
        if not all_positive or scale.item() >= 0:
            x = torch.clamp(x, thd_neg, thd_pos)
        elif scale.item() < 0:
            x = torch.clamp(x, -thd_pos, -thd_neg)
        x = x.round()
        return x.numpy()

    def weight_flatten(self):
        for key in self.quan_params_dict.keys():
            if "conv" in key and len(self.quan_params_dict[key].shape) == 3:
                self.map_quan_params_dict[key] = self.quan_params_dict[key].reshape(-1,
                                                                                    self.quan_params_dict[key].shape[
                                                                                        1] *
                                                                                    self.quan_params_dict[key].shape[
                                                                                        2]).transpose((1, 0))
            elif "conv" in key and len(self.quan_params_dict[key].shape) == 4:
                oc, c, k1, k2 = self.quan_params_dict[key].shape
                self.map_quan_params_dict[key] = self.quan_params_dict[key].transpose((2, 3, 1, 0)).reshape((-1, oc))
            elif "fc" in key and len(self.quan_params_dict[key].shape) == 2:
                self.map_quan_params_dict[key] = self.quan_params_dict[key].transpose((1, 0))
            else:
                raise ValueError("This function only support 2, 3, 4 so far")

    def weight_mapping(self, g_low, g_high, noc=8):
        if not isinstance(noc, int):
            raise ValueError("The number of resistance state must be a int type value!")

        g = np.linspace(g_low, g_high, noc)

        for key in self.map_quan_params_dict.keys():
            if (self.map_quan_params_dict[key] >= 0).all():
                print(key, '>0')
                w_pos = self.map_quan_params_dict[key].astype(int)
                g_pos = g[w_pos]
                w_neg = np.zeros_like(self.map_quan_params_dict[key]).astype(int)
                g_neg = g[w_neg]
                self.RRAM_params_dict[key[5:] + '_g'] = g_pos
            else:
                print(key, '><0')
                w_pos = np.where(self.map_quan_params_dict[key] >= 0, self.map_quan_params_dict[key], 0).astype(int)
                w_neg = np.where(self.map_quan_params_dict[key] <= 0, np.abs(self.map_quan_params_dict[key]), 0).astype(
                    int)
                g_pos = g[w_pos]
                g_neg = g[w_neg]
                x0, x1 = g_pos.shape
                self.RRAM_params_dict[key[5:] + "_g"] = np.stack([g_pos, g_neg], axis=0).transpose((1, 2, 0)).reshape(
                    (x0, -1))

    def inverseTrans(self, out_RRAM, s_a, s_para, cal_mu=True):

        if cal_mu:

            idx = np.array([i for i in range(out_RRAM.shape[1])])
            even_idx = idx[idx % 2 == 0]
            odd_idx = idx[idx % 2 == 1]
            y = (out_RRAM[:, even_idx] - out_RRAM[:, odd_idx]) / 2
        else:
            temp = int(out_RRAM.shape[0] / 2)
            y = (out_RRAM[:temp, :] - out_RRAM[temp:, :]) / 2
        y *= s_para
        if s_a is None:
            return y
        else:
            return np.abs(s_a) * y

    def splitimage(self, image, ks=3, bs=False):
        if torch.is_tensor(image):
            x = image.numpy().clone()
        else:
            x = np.array(image)
        fms = image.shape[1] - ks + 1
        y = np.array([])
        if bs:
            for i in range(fms):
                for j in range(fms):
                    temp = x[:, i:(i + ks), j:(j + ks)].reshape(-1, ks ** 2).T
                    temp = temp.reshape(-1, 72)
                    y = np.append(y, temp)
            y = y.reshape(-1, 72)
        else:
            for i in range(fms):
                for j in range(fms):
                    y = np.append(y, x[i:(i + ks), j:(j + ks)])
            y = y.reshape(-1, ks ** 2)
        return y

    def flattenImage(self, image, bs=True):
        if torch.is_tensor(image):
            x = image.numpy().clone()
        else:
            x = np.array(image)
        if bs:
            x = x.reshape(x.shape[0] * x.shape[1] * x.shape[2])
        else:
            x = x.reshape(x.shape[0] * x.shape[1])
        return x

    def cal(self, sim, row, col, com_col, pix, cal_mu, q, s_a, s_w, fit_parm1, fit_parm2, control: Control = None):

        if sim:
            if cal_mu:
                control.choose_array(id=2)
                x = pix * 0.1
                if q:
                    x *= 0.14
                if 'debug' == sim:
                    emu, estd = debug_mu.pop(0), debug_std.pop(0)
                    w_rram = self.buffer[tuple(row), tuple(col)]
                    w_rram += np.random.randn(*w_rram.shape) * estd + emu
                else:
                    w_rram = control.read_matrix(row, col)
                out_mu_rram = x @ w_rram
                out = self.inverseTrans(out_mu_rram, s_a, s_w, cal_mu=True)
                if q:
                    out /= 0.14
                return out, None
            else:
                control.choose_array(id=3)
                x = (pix ** 2) * 0.1
                if q:
                    x *= 0.02
                if 'debug' == sim:
                    w_var_rram = self.buffer[tuple(row), tuple(col)]
                    w_var_rram_com = np.full(shape=(len(row), len(com_col)), fill_value=self.com_g)
                    emu, estd = debug_mu.pop(0), debug_std.pop(0)
                    w_var_rram += np.random.randn(*w_var_rram.shape) * estd + emu
                else:
                    w_var_rram = control.read_matrix(row, col)
                    w_var_rram_com = control.read_matrix(row, com_col)
                    # w_var_rram_com = np.full(shape=(len(row), len(com_col)), fill_value=self.com_g)
                out_var = x @ w_var_rram
                out_var_com = x @ w_var_rram_com
                out_var = np.vstack((out_var, out_var_com))

                out = self.inverseTrans(out_var, s_a, np.abs(s_w), cal_mu=False)
                if q:
                    out /= 0.02
                return out, None, None
        else:
            if cal_mu:
                control.choose_array(id=2)
                x = pix * 0.1
                if q:
                    x *= 0.14
                out_mu_rram, params1 = control.matrix_calc(x, row, col, out_fit=True, fit_factor=fit_parm1)
                out = self.inverseTrans(out_mu_rram, s_a, s_w, cal_mu=True)
                if q:
                    out /= 0.14
                return out, params1
            else:
                control.choose_array(id=3)
                x = (pix ** 2) * 0.1
                if q:
                    x *= 0.02

                out_var_rram, params1 = control.matrix_calc_v2(x, row, col, out_fit=True, fit_factor=fit_parm1)
                out_com, params2 = control.matrix_calc_v2(x, row, com_col, out_fit=True, fit_factor=fit_parm2)
                out_var_rram = np.vstack((out_var_rram, out_com))
                out = self.inverseTrans(out_var_rram, s_a, np.abs(s_w), cal_mu=False)
                if q:
                    out /= 0.02
                return out, params1, params2

    def forward(self, sim, inputs, num, target, control: Control = None, fit_params=None, ret_final=False, return_out_only=False, random_data: list=None):

        length = (900 * 8 + 64 * 8 + 1 * 10) * 10 * num * len(inputs)
        if random_data is None:
            random_data = np.random.randint(0, 2, size=length)
            print("does't use true random number")
        else:
            assert len(random_data) >= length
        count = 0
        mu_row, mu_col, var_row, var_col = [], [], [], []
        for r in self.mu_row:
            mu_row.extend(r)
        for c in self.mu_col:
            mu_col.extend(c)
        for r in self.var_row:
            var_row.extend(r)
        for c in self.var_col:
            var_col.extend(c)

        if 'debug' == sim:
            global debug_mu, debug_std
            debug_mu = copy.deepcopy(debug_factors_mu)
            debug_std = copy.deepcopy(debug_factors_std)
            self.rram_matrix_write(control, program=False)

        batchsize = len(inputs)
        out_final = torch.zeros(inputs.shape[0], 10, num)
        x = []
        if not isinstance(fit_params, (list, tuple)):
            fit_params = [None] * 14

        for _ in range(inputs.shape[0]):
            x.append(self.splitimage(inputs[_, :, :], 3, bs=False))
        x = np.array(x).reshape(-1, 9)
        for j in range(num):
            # conv1
            out_mu, p = self.cal(sim, mu_row[0], mu_col[0], None, x, True, False,
                                 None,
                                 self.params_dict["conv1.quan_wu_fn.s"],
                                 fit_params[0],
                                 None,
                                 control)
            fit_params[0] = p
            out_var, p1, p2 = self.cal(sim, var_row[0], var_col[0], list(self.com_col)[:len(var_col[0])], x, False, False,
                                       None,
                                       self.params_dict["conv1.quan_sigma_fn.s"],
                                       fit_params[1],
                                       fit_params[2],
                                       control)
            fit_params[1] = p1
            fit_params[2] = p2

            eps_shape = (out_var.shape[0], out_var.shape[1], 10)
            _res = np.prod(eps_shape)
            eps = np.reshape(random_data[count: count + _res], eps_shape).sum(axis=2)
            count = count + _res

            out = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)
            print("conv1")

            out = np.where(out >= 0, out, 0).reshape((batchsize, 30, 30, 8))
            out = np.transpose(out, axes=(0, 3, 1, 2))

            # pooling
            # print("pooling1")
            out = self.p3(torch.tensor(out)).numpy()

            out1 = []
            for _ in range(out.shape[0]):
                out1.append(self.splitimage(out[_, :, :, :], 3, True))
            out = np.array(out1).reshape(-1, 72)

            # conv2
            x1 = self.quantizer(3, self.params_dict["conv2.quan_a_fn.s"], out, True, False)
            out_mu, p = self.cal(sim, mu_row[1], mu_col[1], None, x1[:, :40], True, True,
                                 self.params_dict["conv2.quan_a_fn.s"],
                                 self.params_dict["conv2.quan_wu_fn.s"],
                                 fit_params[3],
                                 None,
                                 control)
            fit_params[3] = p
            out_mu1, p = self.cal(sim, mu_row[2], mu_col[2], None, x1[:, 40:], True, True,
                                  self.params_dict["conv2.quan_a_fn.s"],
                                  self.params_dict["conv2.quan_wu_fn.s"],
                                  fit_params[4],
                                  None,
                                  control)
            out_mu += out_mu1
            fit_params[4] = p
            out_var, p1, p2 = self.cal(sim, var_row[1], var_col[1], list(self.com_col)[:len(var_col[1])], x1[:, :40], False, True,
                                       self.params_dict["conv2.quan_a_fn.s"],
                                       np.abs(self.params_dict["conv2.quan_sigma_fn.s"]),
                                       fit_params[5],
                                       fit_params[7],
                                       control)
            fit_params[5] = p1
            fit_params[7] = p2
            out_var1, p1, p2 = self.cal(sim, var_row[2], var_col[2], list(self.com_col)[:len(var_col[2])], x1[:, 40:], False, True,
                                        self.params_dict["conv2.quan_a_fn.s"],
                                        np.abs(self.params_dict["conv2.quan_sigma_fn.s"]),
                                        fit_params[6],
                                        fit_params[8],
                                        control)
            fit_params[6] = p1
            fit_params[8] = p2

            eps_shape = (out_var.shape[0], out_var.shape[1], 10)
            _res = np.prod(eps_shape)
            eps = np.reshape(random_data[count: count + _res], eps_shape).sum(axis=2)
            count = count + _res

            out1 = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)
            print("conv2")

            out1 = np.where(out1 >= 0, out1, 0).reshape((batchsize, 8, 8, 8))
            out1 = np.transpose(out1, axes=(0, 3, 1, 2))

            # print("pooling2")
            out1 = self.p2(torch.tensor(out1)).numpy()
            mid = np.reshape(out1, (batchsize, -1))

            # fc1
            x2 = self.quantizer(3, self.params_dict["fc1.quan_a_fn.s"], mid, True, False)

            out_mu, p = self.cal(sim, mu_row[3], mu_col[3], None, x2[:, :64], True, True,
                                 self.params_dict["fc1.quan_a_fn.s"],
                                 self.params_dict["fc1.quan_wu_fn.s"],
                                 fit_params[9],
                                 None,
                                 control)
            fit_params[9] = p
            out_mu1, p = self.cal(sim, mu_row[4], mu_col[4], None, x2[:, 64:], True, True,
                                  self.params_dict["fc1.quan_a_fn.s"],
                                  self.params_dict["fc1.quan_wu_fn.s"],
                                  fit_params[10],
                                  None,
                                  control)
            out_mu += out_mu1
            fit_params[10] = p
            out_var, p1, p2 = self.cal(sim, var_row[3], var_col[3], list(self.com_col)[:len(var_col[3])], x2[:, :64], False, True,
                                       self.params_dict["fc1.quan_a_fn.s"],
                                       np.abs(self.params_dict["fc1.quan_sigma_fn.s"]),
                                       fit_params[11],
                                       fit_params[13],
                                       control)
            fit_params[11] = p1
            fit_params[13] = p2
            out_var1, p1, p2 = self.cal(sim, var_row[4], var_col[4], list(self.com_col)[:len(var_col[4])], x2[:, 64:], False, True,
                                        self.params_dict["fc1.quan_a_fn.s"],
                                        np.abs(self.params_dict["fc1.quan_sigma_fn.s"]),
                                        fit_params[12],
                                        fit_params[13],
                                        control)
            out_var += out_var1
            fit_params[12] = p1
            fit_params[13] = p2

            eps_shape = (out_var.shape[0], out_var.shape[1], 10)
            _res = np.prod(eps_shape)
            eps = np.reshape(random_data[count: count + _res], eps_shape).sum(axis=2)
            count = count + _res

            out2 = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)
            print("fc1")

            out_final[:, :, j] = F.log_softmax(torch.tensor(out2), dim=1).data
        log_outputs = logmeanexp(out_final, dim=2)

        if return_out_only:
            return log_outputs, out_final

        accs = acc(log_outputs, torch.tensor(target))
        print(np.mean(accs))
        accuracy = np.mean(accs)

        if ret_final:
            return out_final.detach(), torch.tensor(target), fit_params, accuracy

        return log_outputs.detach(), torch.tensor(target), fit_params, accuracy


