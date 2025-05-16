import copy
import os
import pickle

import torch
import numpy as np
from rram_api import Control
from torch.nn import functional as F
import time
import matplotlib.pyplot as plt

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
    binary = False

    def __init__(self, weight_path, clt_num=10, P_M):
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

        self.P_M = P_M # for PCAM dataset or MNIST dataset
        if P_M = "PCAM":
            self.p1 = torch.nn.MaxPool2d(2)
            self.p2 = torch.nn.MaxPool2d(2)

            self.mu_row = [[range(1, 10)], [range(10, 50), range(0, 32)], [range(0, 64), range(0, 64)]]
            self.mu_col = [[list(range(16, 26)) + list(range(27, 33))], [range(33, 49), range(62, 78)], [range(78, 98), range(98, 118)]]

            self.var_row = [[range(0, 9)], [range(9, 49), range(0, 32)], [range(0, 64), range(0, 64)]]
            self.var_col = [[range(0, 8)], [range(0, 8), range(16, 24)], [range(54, 64), range(26, 36)]]

            self.com_row, self.com_col = range(64), range(36, 46)
        elif P_M = "MNIST":
            self.p1 = torch.nn.MaxPool2d(3)
            self.p2 = torch.nn.MaxPool2d(2)

            self.mu_row = [[range(1, 10)], [range(10, 50), range(0, 32)], [range(0, 64), range(0, 64)]]
            self.mu_col = [[list(range(16, 26)) + list(range(27, 33))], [range(33, 49), range(62, 78)], [range(78, 98), range(98, 118)]]

            self.var_row = [[range(0, 9)], [range(9, 49), range(0, 32)], [range(0, 64), range(0, 64)]]
            self.var_col = [[range(0, 8)], [range(0, 8), range(16, 24)], [range(54, 64), range(26, 36)]]

            self.com_row, self.com_col = range(64), range(36, 46)
        else:
            raise ValueError("ONLY SUPPORT MNIST OR PCAM !!!")
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
        """
        This function is designed to transform the output from RRAM_array to numerical value and finish anti-quantization.
        W = w_pos - w_neg
        g_pos = 20μS * w_pos + 40μS
        g_neg = 20μS * w_neg + 40μS
        v_input = x * 0.1
        v_input * (g_pos - g_neg) -> 4μA * x * w , this is implemented in RRAM array.
        To transform the output of RRAM array to numerical value, the output of RRAM out_RRAM need to be processed:
        y = y_RRAM / 2μA = x * w
        """
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

    def rram_matrix_write(self, control: Control = None, program=True):
        mu_row = copy.deepcopy(self.mu_row)
        mu_col = copy.deepcopy(self.mu_col)
        var_row = copy.deepcopy(self.var_row)
        var_col = copy.deepcopy(self.var_col)

        bias_g = 4

        if program:
            control.matrix_write(self.com_row, self.com_col, np.full((len(self.com_row), len(self.com_col)), fill_value=self.com_g) + bias_g)

        conductance_compare = []
        for k in self.RRAM_params_dict.keys():
            g_matrix = self.RRAM_params_dict[k]
            # print(g_matrix)
            if 'mu' in k:
                if isinstance(control, Control):
                    control.choose_array(id=2)
                row, col = mu_row.pop(0), mu_col.pop(0)
            else:
                if isinstance(control, Control):
                    control.choose_array(id=3)
                row, col = var_row.pop(0), var_col.pop(0)
            r_idx = 0
            c_idx = 0
            _conductance_compare = []
            for _row, _col in zip(row, col):
                # _g_matrix = g_matrix[r_idx: r_idx + _row.stop - _row.start, : _col.stop - _col.start]
                _g_matrix = g_matrix[r_idx: r_idx + _row.stop - _row.start, : len(_col)]
                r_idx = r_idx + _row.stop - _row.start

                self.buffer[tuple(_row), tuple(_col)] = _g_matrix

                if program:
                    # print(k, _row, _col)
                    # control.matrix_write(_row, _col, _g_matrix, tolerant_value=2)
                    # cg_matrix = control.read_matrix(_row, _col)
                    # err = cg_matrix - _g_matrix
                    # control.show_matrix(err)
                    # print(err.max(), err.mean(), err.min(), err.std())
                    # print(np.argwhere(err == err.max()))

                    if 'mu' in k:
                        tg_mat = []
                        for i, c in enumerate(_col):
                            if i % 2 == 1:
                                pos_mat = control.read_matrix(_row, [original_col])
                                neg_mat = _g_matrix[:, i: i + 1] - (original_g - pos_mat)
                                neg_mat = np.clip(neg_mat, 40, 240)  # accelerate program
                                # pos_mat = _g_matrix[:, i - 1: i]
                                # neg_mat = _g_matrix[:, i: i + 1]
                                control.matrix_write(_row, [c], neg_mat + bias_g, tolerant_value=2)
                                tg_mat.extend([pos_mat, neg_mat])
                            else:
                                original_col = c
                                original_g = _g_matrix[:, i: i + 1]
                                control.matrix_write(_row, [c], original_g + bias_g, tolerant_value=2)
                            # print(i)
                        tg_mat = np.concatenate(tg_mat, axis=1)
                    elif 'sigma' in k:
                        com_mat = control.read_matrix(_row, list(self.com_col)[:len(_col)])
                        tg_mat = _g_matrix - (self.com_g - com_mat)
                        tg_mat = np.clip(tg_mat, 40, 240)  # accelerate program
                        # tg_mat = _g_matrix
                        control.matrix_write(_row, _col, tg_mat + bias_g, tolerant_value=2)

                    cg_matrix = control.read_matrix(_row, _col)
                    err = cg_matrix - tg_mat
                    control.show_matrix(err, title=k, xticklabels=_col, yticklabels=_row)
                    print(k, '-:')
                    print('error max:', round(err.max(), 3), 'error min:', round(err.min(), 3))
                    print('error mean:', round(err.mean(), 3), 'error std:', round(err.std(), 3))
                    print('maximum variance location', np.argwhere(np.abs(err) == np.abs(err).max()))

        return conductance_compare

    def cal(self, sim, row, col, com_col, pix, cal_mu, q, s_a, s_w, fit_parm1, fit_parm2, control: Control = None):

        if sim:
            if cal_mu:
                x = pix * 0.1
                if q:
                    x *= 0.14
                w_rram = self.buffer[tuple(row), tuple(col)]
                out_mu_rram = x @ w_rram
                out = self.inverseTrans(out_mu_rram, s_a, s_w, cal_mu=True)
                if q:
                    out /= 0.14
                return out, None
            else:
                x = (pix ** 2) * 0.1
                if q:
                    x *= 0.02
                w_var_rram = self.buffer[tuple(row), tuple(col)]
                w_var_rram_com = np.full(shape=(len(row), len(com_col)), fill_value=self.com_g)
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

                if self.binary:
                    print("Mu Binary...")
                    x = pix
                    out_mu_rram, params1 = control.matrix_calc_binary(x, 3, row, col, inputs_scale=0.1,
                                                                      out_fit=True, fit_factor=fit_parm1)
                    out_mu_rram = out_mu_rram * 0.1
                else:
                    x = pix * 0.1
                    if q:
                        x *= 0.14
                    out_mu_rram, params1 = control.matrix_calc(x, row, col, out_fit=True, fit_factor=fit_parm1)
                    if q:
                        out_mu_rram /= 0.14
                out = self.inverseTrans(out_mu_rram, s_a, s_w, cal_mu=True)
                return out, params1
            else:
                control.choose_array(id=3)
                if self.binary:
                    print('SD Binary...')
                    x = pix ** 2
                    out_var_rram, params1 = control.matrix_calc_binary(x, 6, row, col, inputs_scale=0.1,
                                                                      out_fit=True, fit_factor=fit_parm1
                                                                      )
                    out_com, params2 = control.matrix_calc_binary(x, 6, row, com_col, inputs_scale=0.1,
                                                                  out_fit=True, fit_factor=fit_parm2
                                                                  )
                    out_var_rram = np.vstack((out_var_rram, out_com))
                    out_var_rram = out_var_rram * 0.1
                else:
                    x = (pix ** 2) * 0.1
                    if q:
                        x *= 0.02

                    out_var_rram, params1 = control.matrix_calc_v2(x, row, col, out_fit=True, fit_factor=fit_parm1)
                    out_com, params2 = control.matrix_calc_v2(x, row, com_col, out_fit=True, fit_factor=fit_parm2)
                    out_var_rram = np.vstack((out_var_rram, out_com))
                    if q:
                        out_var_rram /= 0.02
                out = self.inverseTrans(out_var_rram, s_a, np.abs(s_w), cal_mu=False)
                return out, params1, params2

    def forward_MNIST(self, sim, inputs, num, control: Control = None, fit_params=None, ret_final=False):

        out_final = torch.zeros(inputs.shape[0], 10, num)
        out_final_1 = torch.zeros(inputs.shape[0], 10, num)

        if not isinstance(fit_params, (list, tuple)):
            fit_params = [None] * 14

        x = []
        batchsize = len(inputs)
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

            eps = np.random.randint(0, 2, size=(out_var.shape[0], out_var.shape[1], 10)).sum(axis=2)

            out = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)

            out = np.where(out >= 0, out, 0).reshape((batchsize, 30, 30, 8))
            out = np.transpose(out, axes=(0, 3, 1, 2))

            # pooling
            out = self.p1(torch.tensor(out)).numpy()

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
            out_var += out_var1

            eps = np.random.randint(0, 2, size=(out_var.shape[0], out_var.shape[1], 10)).sum(axis=2)

            out1 = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)

            out1 = np.where(out1 >= 0, out1, 0).reshape((batchsize, 8, 8, 8))
            out1 = np.transpose(out1, axes=(0, 3, 1, 2))

            # print("pooling2")
            out1 = self.p2(torch.tensor(out1)).numpy()
            _features.append(out1)
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

            eps = np.random.randint(0, 2, size=(out_var.shape[0], out_var.shape[1], 10)).sum(axis=2)

            out2 = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)

            out_final_1[:, :, j] = F.log_softmax(torch.tensor(out2), dim=1).data
            out_final[:, :, j] = torch.tensor(out2).data

        return out_final_1, out_final

    def forward_PCAM(self):

        batchsize = len(inputs)
        out_final = torch.zeros(inputs.shape[0], 2, num)
        out_final_1 = torch.zeros(inputs.shape[0], 2, num)

        x = []
        if not isinstance(fit_params, (list, tuple)):
            fit_params = [None] * 19

        inputs = inputs.numpy()

        for _ in range(inputs.shape[0]):
            x.append(self.splitimage(inputs[_, :, :, :], 3, bs=False))
        x = np.array(x).reshape(-1, 27)
        _features = []

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

            eps = np.random.randint(0, 2, size=(out_var.shape[0], out_var.shape[1], 10)).sum(axis=2)
            out = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)
            print("conv1")

            out = np.where(out >= 0, out, 0).reshape((batchsize, 16, 16, 16))
            out = np.transpose(out, axes=(0, 3, 1, 2))

            out = self.p3(torch.tensor(out)).numpy()

            out1 = []
            for _ in range(out.shape[0]):
                out1.append(self.splitimage(out[_, :, :, :], 3, True))
            out = np.array(out1).reshape(-1, 144)

            # conv2
            x1 = self.quantizer(3, self.params_dict["conv2.quan_a_fn.s"], out, True, False)
            out_mu, p = self.cal(sim, mu_row[1], mu_col[1], None, x1[:, :32], True, True,
                                 self.params_dict["conv2.quan_a_fn.s"],
                                 self.params_dict["conv2.quan_wu_fn.s"],
                                 fit_params[3],
                                 None,
                                 control,
                                 "conv2_mu_1")
            fit_params[3] = p
            out_mu1, p = self.cal(sim, mu_row[2], mu_col[2], None, x1[:, 32:88], True, True,
                                  self.params_dict["conv2.quan_a_fn.s"],
                                  self.params_dict["conv2.quan_wu_fn.s"],
                                  fit_params[4],
                                  None,
                                  control,
                                  "conv2_mu_2")
            out_mu += out_mu1
            fit_params[4] = p
            out_mu1, p = self.cal(sim, mu_row[2], mu_col[2], None, x1[:, 88:], True, True,
                                  self.params_dict["conv2.quan_a_fn.s"],
                                  self.params_dict["conv2.quan_wu_fn.s"],
                                  fit_params[5],
                                  None,
                                  control,
                                  "conv2_mu_3")
            out_mu += out_mu1
            fit_params[5] = p

            out_var, p1, p2 = self.cal(sim, var_row[1], var_col[1], list(self.com_col)[:len(var_col[1])], x1[:, :32], False, True,
                                       self.params_dict["conv2.quan_a_fn.s"],
                                       np.abs(self.params_dict["conv2.quan_sigma_fn.s"]),
                                       fit_params[6],
                                       fit_params[7],
                                       control,
                                       "conv2_sigma_1")
            fit_params[6] = p1
            fit_params[7] = p2
            out_var1, p1, p2 = self.cal(sim, var_row[2], var_col[2], list(self.com_col)[:len(var_col[2])], x1[:, 32:88], False, True,
                                        self.params_dict["conv2.quan_a_fn.s"],
                                        np.abs(self.params_dict["conv2.quan_sigma_fn.s"]),
                                        fit_params[8],
                                        fit_params[9],
                                        control,
                                        "conv2_sigma_2")
            out_var += out_var1
            fit_params[8] = p1
            fit_params[9] = p2
            out_var1, p1, p2 = self.cal(sim, var_row[2], var_col[2], list(self.com_col)[:len(var_col[2])], x1[:, 88:],
                                        False, True,
                                        self.params_dict["conv2.quan_a_fn.s"],
                                        np.abs(self.params_dict["conv2.quan_sigma_fn.s"]),
                                        fit_params[10],
                                        fit_params[11],
                                        control,
                                        "conv2_sigma_3")
            out_var += out_var1
            fit_params[10] = p1
            fit_params[11] = p2

            eps = np.random.randint(0, 2, size=(out_var.shape[0], out_var.shape[1], 10)).sum(axis=2)
            print("conv2")
            out1 = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)

            out1 = np.where(out1 >= 0, out1, 0).reshape((batchsize, 6, 6, 16))
            out1 = np.transpose(out1, axes=(0, 3, 1, 2))

            # print("pooling2")
            out1 = self.p2(torch.tensor(out1)).numpy()
            _features.append(out1)
            mid = np.reshape(out1, (batchsize, -1))

            # fc1
            x2 = self.quantizer(3, self.params_dict["fc1.quan_a_fn.s"], mid, True, False)
            out_mu, p = self.cal(False, mu_row[0], mu_col[0], None, x2[:, :56], True, True,
                                 self.params_dict["fc1.quan_a_fn.s"],
                                 self.params_dict["fc1.quan_wu_fn.s"],
                                 fit_params[12],
                                 None,
                                 control,
                                 "fc1_mu_1")
            fit_params[12] = p
            out_mu1, p = self.cal(False, mu_row[1], mu_col[1], None, x2[:, 56:112], True, True,
                                  self.params_dict["fc1.quan_a_fn.s"],
                                  self.params_dict["fc1.quan_wu_fn.s"],
                                  fit_params[13],
                                  None,
                                  control,
                                  "fc1_mu_2")
            out_mu += out_mu1
            fit_params[13] = p
            out_mu1, p = self.cal(False, mu_row[2], mu_col[2], None, x2[:, 112:], True, True,
                                  self.params_dict["fc1.quan_a_fn.s"],
                                  self.params_dict["fc1.quan_wu_fn.s"],
                                  fit_params[14],
                                  None,
                                  control,
                                  "fc1_mu_3")
            out_mu += out_mu1
            fit_params[14] = p

            out_var, p1, p2 = self.cal(sim, var_row[0], var_col[0], list(self.com_col)[:len(var_col[0])], x2[:, :56], False, True,
                                       self.params_dict["fc1.quan_a_fn.s"],
                                       np.abs(self.params_dict["fc1.quan_sigma_fn.s"]),
                                       fit_params[15],
                                       fit_params[16],
                                       control,
                                       "fc1_sigma_1")
            fit_params[15] = p1
            fit_params[16] = p2
            out_var1, p1, p2 = self.cal(sim, var_row[1], var_col[1], list(self.com_col)[:len(var_col[1])], x2[:, 56:112], False, True,
                                        self.params_dict["fc1.quan_a_fn.s"],
                                        np.abs(self.params_dict["fc1.quan_sigma_fn.s"]),
                                        fit_params[17],
                                        fit_params[16],
                                        control,
                                        "fc1_sigma_2")
            out_var += out_var1
            fit_params[17] = p1
            fit_params[16] = p2

            out_var1, p1, p2 = self.cal(sim, var_row[2], var_col[2], list(self.com_col)[:len(var_col[2])], x2[:, 112:],
                                        False, True,
                                        self.params_dict["fc1.quan_a_fn.s"],
                                        np.abs(self.params_dict["fc1.quan_sigma_fn.s"]),
                                        fit_params[18],
                                        fit_params[16],
                                        control,
                                        "fc1_sigma_3")
            out_var += out_var1
            fit_params[18] = p1
            fit_params[16] = p2

            eps = np.random.randint(0, 2, size=(out_var.shape[0], out_var.shape[1], 10)).sum(axis=2)
            print("fc1")
            out2 = out_mu + np.sqrt(np.abs(out_var)) * (eps - 5)

            out_final_1[:, :, j] = F.log_softmax(torch.tensor(out2), dim=1).clone().detach().data
            out_final[:, :, j] = torch.tensor(out2).clone().detach().data

    def forward(self, sim, inputs, num, target, control: Control = None, fit_params=None, ret_final=False):

        mu_row, mu_col, var_row, var_col = [], [], [], []
        for r in self.mu_row:
            mu_row.extend(r)
        for c in self.mu_col:
            mu_col.extend(c)
        for r in self.var_row:
            var_row.extend(r)
        for c in self.var_col:
            var_col.extend(c)

        if self.P_M = "MNIST":
            out_final_1, out_final = forward_MNIST(sim, inputs, num, control: Control = None, fit_params=None, ret_final=False)
        elif self.P_M = "PCAM":
            out_final_1, out_final = forward_PCAM(sim, inputs, num, control: Control = None, fit_params=None, ret_final=False)
        else:
            raise ValueError("ONLY SUPPORT PCAM OR MNIST dataset !!!")

        log_outputs = logmeanexp(out_final_1, dim=2)

        features.append(out_final)

        accs = acc(log_outputs, torch.tensor(target))

        accuracy = np.mean(accs)

        print(accuracy)

        if ret_final:
            return log_outputs.detach(), out_final.detach(), torch.tensor(target), fit_params, accuracy

        return log_outputs.detach(), torch.tensor(target), fit_params, accuracy




if __name__ == '__main__':
    # fit_params = np.load(r"D:\RRAM_16k\rram_api\test\matrix_w\jake_lu\fit_params.npy", allow_pickle=True)
    Process.binary = False
    P_M = "MNIST"

    if P_M = "PCAM":
        process = Process("quan_model_PCAM_lrt_relu_clt_10_noise_2.pt", P_M)
    else:
        process = Process('quan_model_test_lrt_relu_clt_10_noise_2.pt', P_M)
    if process.binary:
        print('*' * 20, 'Binary input !!!', '*' * 20)

    avg_num = 10
    debug_factors_mu = [0] * 10 * avg_num
    # debug_factors_mu = [-1.2, -0.8, -1.4, -1.4, -6.7, -5.8, -1.7, -1.9, -5.9, -6.3]
    # debug_factors_std = [4] * 10
    debug_factors_std = [3] * 10 * avg_num
    # debug_factors_std = [2.6, 5.4, 3.9, 3.9, 9, 3.9, 4.3, 4.3, 4.0, 3.8]

    # +++++++++++++++++++++++ original data ++++++++++++++++++++++
    import json
    x = np.load(r"D:\RRAM_16k\rram_api\test\matrix_w\jake_lu\data.npy")[4200:4300]
    print(x.shape)
    y = np.load(r"D:\RRAM_16k\rram_api\test\matrix_w\jake_lu\label.npy")[4200:4300]

    Inference = True
    load_fit_factors = False
    acc_ls = []

    features = []
    if Inference:
        bs = 100
        in_len = int(x.shape[0] / bs)
        outputs, targets = [], []

        if load_fit_factors:
            fit_factors = list(np.load('fit_factors.npy', allow_pickle=True))
        else:
            fit_factors = [None] * 14

        with Control() as control:
            for m in range(in_len):
                # if m == in_len - 1:
                #     x_inp = x[m * 128:, :, :]
                #     y_inp = y[m:]
                # else:
                x_inp = x[bs * m:bs * (m + 1), :, :]
                y_inp = y[bs * m:bs * (m + 1)]

                print(x_inp.shape)
                print('start time', time.strftime('%m-%d-%H_%M_%S'))
                _output, _target, fit_factors, accuracy = process.forward('debug', x_inp, avg_num, y_inp, control=control, fit_params=fit_factors)
                outputs.append(_output)
                targets.append(_target)

                acc_ls.append(accuracy)

                import json

                with open('accuracy.json', 'w') as f:
                    json.dump(acc_ls, f, indent=2)

                print('end time', time.strftime('%m-%d-%H_%M_%S'))
            outputs = torch.concat(outputs, dim=0)
            targets = torch.concat(targets, dim=0)
            accuracy = acc(outputs, targets)
            print('Accuracy:', round(accuracy * 100, 2), '%')

            from collections import defaultdict

            count = defaultdict(int)
            for i in targets.numpy():
                count[i] += 1
        # np.save(f"train_set/features.npy", np.array(features), allow_pickle=True)
    else:
        with Control() as control:
            conductance_compare = process.rram_matrix_write(control=control)

    # ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    # # ================== adversarial test ==================
    # import json
    #
    # fit_factors = list(np.load('fit_factors.npy', allow_pickle=True))
    # bs = 100
    #
    # start_index = 100
    # input_num = 100
    # directory = 'adversarial_data/pgd_l2v2'
    # output_path = os.path.join('adversarial_output', os.path.split(directory)[-1])
    # os.makedirs(output_path, exist_ok=True)
    #
    # features = []
    #
    # with Control() as control:
    #     # 加载对抗样本数据集
    #     # att_type = ["noise", "gaussian", "fgsm", "pgd", "bim"]
    #     att_type = ["fgsm"]
    #     epsilon = [0.025]
    #     for att in att_type:
    #         for eps in epsilon:
    #             print(att, eps)
    #             with open(f"adv_dataset/{att}/eps_{eps}_adv_data.json", "r") as f:
    #                 adv_data = np.array(json.load(f)).squeeze()[:1000]
    #             with open(f"adv_dataset/{att}/eps_{eps}_adv_label.json", "r") as f:
    #                 adv_label = np.array(json.load(f)).squeeze()[:1000]
    #
    #             length = int(adv_data.shape[0] / bs)
    #             out_final = []
    #             outputs = []
    #             targets = []
    #             for m in range(length):
    #                 x_inp = adv_data[m * bs:(m + 1) * bs, :, :]
    #                 y_inp = adv_label[m * bs:(m + 1) * bs]
    #                 _log_output, _output, _target, fit_factors, accuracy = process.forward(False, x_inp, avg_num, y_inp, control=control,
    #                                                                           fit_params=fit_factors, ret_final=True)
    #                 out_final.append(_output.numpy())
    #                 outputs.append(_log_output)
    #                 targets.append(_target)
    #             outputs = torch.concat(outputs, dim=0)
    #             targets = torch.concat(targets, dim=0)
    #             _accuracy = acc(outputs, targets)
    #             print('Accuracy:', round(_accuracy * 100, 2), '%')
    #             # np.save(f"adv_dataset/{att}/eps_{eps}_output_2.npy", np.array(out_final), allow_pickle=True)
    #
    #     # fs = os.listdir(directory)
    #     # for i in range(len(fs) // 2):
    #     #     if not any([k in fs[2 * i] for k in ['_0.05_', '_0.1_', '_0.15_', '_0.2_', '_0.25_', '_0.3_']]):
    #     #     # if not any([k in fs[2 * i] for k in ['_0.05_', '_0.1_', '_0.15_', '_0.3_']]):
    #     #         continue
    #     #
    #     #     index.append(float(fs[2 * i].split('_')[1]))
    #     #
    #     #     data_path = os.path.join(directory, fs[2 * i])
    #     #     label_path = os.path.join(directory, fs[2 * i + 1])
    #     #     print(data_path, label_path)
    #     #     with open(data_path, 'r') as f:
    #     #         data = np.array(json.load(f)).squeeze()
    #     #     with open(label_path, 'r') as f:
    #     #         label = np.array(json.load(f)).squeeze()
    #     #
    #     #     # data, label = x, y
    #     #
    #     #     out_file = fs[2 * i].replace('_data', '_out')
    #     #     out_path = os.path.join(output_path, out_file)
    #     #
    #     #     data, label = data[start_index:start_index + input_num], label[start_index: start_index + input_num]
    #     #     print(data.shape, label.shape)
    #     #     dummy = np.arange(10).reshape((-1, 1))
    #     #     count = np.sum(label == dummy, axis=1)
    #     #     print(count)
    #     #
    #     #     print('start time', time.strftime('%m-%d-%H_%M_%S'))
    #     #     _output, _target, fit_factors, accuracy = process.forward(False, data, avg_num, label, control=control, fit_params=fit_factors, ret_final=True)
    #     #     print('end time', time.strftime('%m-%d-%H_%M_%S'))
    #     #     acc_ls.append(accuracy)
    #
    #         # torch.save(_output, out_path)
    # # ======================================================

