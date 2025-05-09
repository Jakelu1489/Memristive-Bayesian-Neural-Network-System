# -*- coding: utf-8 -*-
import random

import wx
import wx.lib.agw.shapedbutton as sb
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends import backend_wxagg
import time

from rram_api import Control
from process_single_image import Process

import torch
from torch.nn import functional as F


class MainFrame(wx.Frame):

    def __init__(self, parent):
        wx.Frame.__init__(self, parent, style=wx.DEFAULT_FRAME_STYLE ^ wx.RESIZE_BORDER)

        self.SetTitle("MINST Testset for Memristive BayCNN")
        self.SetSize((960, 800))
        self._init_ui()
        self.Center()
        self.image_id = None
        self.ens = 10
        self.data = np.load("data.npy")
        self.label = np.load("label.npy")
        self.Da_to_test = np.array([])
        self.Label_to_test = None

        self.process = Process('quan_model_test_lrt_relu_clt_10_noise_2.pt')

    def _init_ui(self):
        self.panel = wx.Panel(self, -1)
        self.label_font = wx.Font(14, wx.FONTFAMILY_TELETYPE, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_SEMIBOLD)
        self.text_font = wx.Font(10, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_MEDIUM)
        self.cpy_font = wx.Font(13, wx.FONTFAMILY_DEFAULT, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_SEMIBOLD)

        cpy = """
                    \nVersion and copyright authorized by Lu Jian.\n
                    \n     E-mail: lujian@zhejianglab.com         \n"""
        cpy_txt = wx.StaticText(self.panel, -1, cpy)
        cpy_txt.SetFont(self.cpy_font)
        cpy_txt.SetForegroundColour("blue")

        ws = wx.BoxSizer(wx.HORIZONTAL)
        ls = wx.BoxSizer(wx.VERTICAL)
        rs = wx.BoxSizer(wx.VERTICAL)
        sb = self.set_box()
        rb = self.run_box()
        ib = self.info_box()
        pb = self.pred_box()
        plb = self.plot_box()
        ls.Add(sb, 0, wx.ALL | wx.LEFT, 10)
        ls.Add(rb, 0, wx.ALL | wx.LEFT, 10)
        ls.Add(ib, 0, wx.ALL | wx.LEFT, 10)
        rs.Add(plb, 0, wx.ALL | wx.RIGHT, 10)
        rs.Add(pb, 0, wx.ALL | wx.RIGHT, 10)
        rs.Add(cpy_txt, 0, wx.ALL | wx.CENTER, 10)
        ws.Add(ls, 0, wx.ALL | wx.LEFT, 10)
        ws.Add(rs, 0, wx.ALL | wx.RIGHT, 10)
        self.panel.SetSizerAndFit(ws)
        self.panel.Layout()

    def set_box(self):
        set_box = wx.StaticBox(self.panel, -1, "Setting", size=(400, 75))
        set_box.SetFont(self.label_font)
        setb_sizer = wx.StaticBoxSizer(set_box, wx.VERTICAL)

        image_id = wx.BoxSizer(wx.HORIZONTAL)
        st = wx.StaticText(self.panel, -1, "Image ID:")
        st.SetFont(self.text_font)
        image_id.Add(st, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)

        self.image = wx.TextCtrl(self.panel, -1, style=wx.TE_PROCESS_ENTER | wx.ALIGN_LEFT)
        image_id.Add(self.image, 0, wx.ALL | wx.RIGHT | wx.CENTER, 10)
        self.image.Bind(wx.EVT_TEXT_ENTER, self.get_ID)

        run_btn = wx.Button(self.panel, -1, "Random", size=(75, 28))
        run_btn.SetFont(self.text_font)
        image_id.Add(run_btn, 0, wx.ALL | wx.RIGHT | wx.CENTER, 10)
        run_btn.Bind(wx.EVT_BUTTON, self.get_random_ID)

        inf_N = wx.BoxSizer(wx.HORIZONTAL)
        st = wx.StaticText(self.panel, -1, "Inference:")
        st.SetFont(self.text_font)
        inf_N.Add(st, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)

        self.N_time = wx.TextCtrl(self.panel, -1, style=wx.TE_PROCESS_ENTER | wx.ALIGN_LEFT)
        self.N_time.SetLabel("10")
        inf_N.Add(self.N_time, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)
        self.N_time.Bind(wx.EVT_TEXT_ENTER, self.get_ens)

        setb_sizer.Add(image_id, 0, wx.ALL | wx.LEFT, 10)
        setb_sizer.Add(inf_N, 0, wx.ALL | wx.LEFT, 10)

        return setb_sizer

    def run_box(self):
        rb = wx.StaticBox(self.panel, -1, "Running", size=(400, 100))
        rb.SetFont(self.label_font)
        rb_sizer = wx.StaticBoxSizer(rb, wx.HORIZONTAL)

        self.run_btn = sb.SButton(self.panel, label="RUN", size=(75, 75))

        self.run_btn.Bind(wx.EVT_BUTTON, self.run)

        rb_sizer.Add(self.run_btn, 0, wx.ALL | wx.LEFT, 5)

        self.gauge = wx.Gauge(self.panel, -1, range=20, size=(280, 25), style=wx.GA_HORIZONTAL | wx.GA_TEXT)

        rb_sizer.Add(self.gauge, 0, wx.ALL | wx.CENTER, 5)

        return rb_sizer

    def info_box(self):
        ib = wx.StaticBox(self.panel, -1, "INFO", size=(400, 300))
        ib.SetFont(self.label_font)
        ib_sizer = wx.StaticBoxSizer(ib, wx.VERTICAL)

        imb = wx.StaticBox(self.panel, label="Generated ramdom number", size=(360, 120))
        imb_sizer = wx.StaticBoxSizer(imb, wx.VERTICAL)
        self.info_fig = plt.Figure(figsize=(2, 2.5))
        self.info_canvas = backend_wxagg.FigureCanvasWxAgg(self.panel, -1, self.info_fig)
        imb_sizer.Add(self.info_canvas, 0, wx.EXPAND | wx.ALL, 1)

        self.log_text_ctrl = wx.TextCtrl(self.panel, -1, style=wx.TE_MULTILINE | wx.TE_READONLY, size=(380, 100))

        ib_sizer.Add(self.log_text_ctrl, 0, wx.ALL | wx.CENTER, 3)
        ib_sizer.Add(imb_sizer, 0, wx.ALL | wx.EXPAND, 3)

        return ib_sizer

    def plot_box(self):
        plb = wx.StaticBox(self.panel, -1, "Target", size=(400, 500))
        plb.SetFont(self.label_font)
        plb_sizer = wx.StaticBoxSizer(plb, wx.VERTICAL)

        imb = wx.StaticBox(self.panel, label="Target Image", size=(360, 200))
        imb.SetFont(self.text_font)
        imb_sizer = wx.StaticBoxSizer(imb, wx.VERTICAL)
        self.img_fig = plt.Figure(figsize=(5, 3))
        self.img_canvas = backend_wxagg.FigureCanvasWxAgg(self.panel, -1, self.img_fig)
        imb_sizer.Add(self.img_canvas, 0, wx.EXPAND | wx.ALL, 5)

        txt_sizer = wx.BoxSizer(wx.HORIZONTAL)
        st = wx.StaticText(self.panel, -1, "True Label:")
        st.SetFont(self.text_font)
        txt_sizer.Add(st, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)
        self.image_label = wx.TextCtrl(self.panel, -1, style=wx.CENTER, size=(100, 25))
        txt_sizer.Add(self.image_label, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)

        plb_sizer.Add(imb_sizer, 0, wx.ALL | wx.CENTER, 5)
        plb_sizer.Add(txt_sizer, 0, wx.ALL | wx.CENTER, 5)

        return plb_sizer

    def pred_box(self):
        pb = wx.StaticBox(self.panel, -1, "Prediction", size=(400, 200))
        pb.SetFont(self.label_font)
        pb_sizer = wx.StaticBoxSizer(pb, wx.VERTICAL)

        fr = wx.BoxSizer(wx.HORIZONTAL)
        st = wx.StaticText(self.panel, -1, "Prediction Label:")
        st.SetFont(self.text_font)
        fr.Add(st, 0, wx.ALL | wx.LEFT | wx.CENTER, 5)
        self.pred = wx.TextCtrl(self.panel, -1, style=wx.ALIGN_LEFT, size=(75, 25))
        fr.Add(self.pred, 0, wx.ALL | wx.LEFT | wx.CENTER, 5)

        st = wx.StaticText(self.panel, -1, "Prediction Uncer.:")
        st.SetFont(self.text_font)
        fr.Add(st, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)
        self.uncer = wx.TextCtrl(self.panel, -1, style=wx.ALIGN_LEFT, size=(75, 25))
        fr.Add(self.uncer, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)

        sr = wx.BoxSizer(wx.HORIZONTAL)
        st = wx.StaticText(self.panel, -1, "Aleatoric Uncer.:")
        st.SetFont(self.text_font)
        sr.Add(st, 0, wx.ALL | wx.LEFT | wx.CENTER, 5)
        self.ale = wx.TextCtrl(self.panel, -1, style=wx.ALIGN_LEFT, size=(75, 25))
        sr.Add(self.ale, 0, wx.ALL | wx.LEFT | wx.CENTER, 5)

        st = wx.StaticText(self.panel, -1, "Epistemic Uncer. :")
        st.SetFont(self.text_font)
        sr.Add(st, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)
        self.eps = wx.TextCtrl(self.panel, -1, style=wx.ALIGN_LEFT, size=(75, 25))
        sr.Add(self.eps, 0, wx.ALL | wx.RIGHT | wx.CENTER, 5)

        pb_sizer.Add(fr, 0, wx.ALL | wx.CENTER, 10)
        pb_sizer.Add(sr, 0, wx.ALL | wx.CENTER, 10)

        return pb_sizer

    def get_random_ID(self, evt):
        self.image_id = np.random.randint(0, 9999)

        self.image.Clear()
        self.image.AppendText(str(self.image_id))
        self.Da_to_test = self.data[self.image_id]
        self.plot_img(self.Da_to_test)

        self.image_label.Clear()
        self.Label_to_test = int(self.label[self.image_id])
        self.image_label.AppendText(str(self.Label_to_test))
        self.log_text_ctrl.AppendText(f"The image ID is {self.image_id}.\t Confirmed!!!\n")

    def get_ID(self, evt):
        if self.image.IsEmpty():
            # raise ValueError("Please enter valid number")
            wx.MessageBox("Please enter a valid number: 0 ~ 9999", "Error", wx.OK | wx.ICON_ERROR)
        else:
            id = int(self.image.GetValue())
            if -1 < id < 10000:
                self.image_id = id

                self.Da_to_test = self.data[self.image_id]
                self.plot_img(self.Da_to_test)

                self.image_label.Clear()
                self.Label_to_test = int(self.label[self.image_id])
                self.image_label.AppendText(str(self.Label_to_test))
                self.log_text_ctrl.AppendText(f"The image ID is {self.image_id}.\t Confirmed!!!\n")
            else:
                wx.MessageBox("Please enter a valid number: 0 ~ 9999", "Error", wx.OK | wx.ICON_ERROR)
                self.image.Clear()

    def get_ens(self, evt):
        ens = int(self.N_time.GetValue())
        if ens > 20:
            wx.MessageBox("It gonna take a long time to run!", "Warning", wx.OK | wx.ICON_WARNING)
            self.ens = ens
            self.log_text_ctrl.AppendText(f"The forward inference times is {self.ens}.\t Confirmed!!!\n")
        elif 0 < ens < 20:
            self.ens = ens
            self.log_text_ctrl.AppendText(f"The forward inference times is {self.ens}.\t Confirmed!!!\n")
        else:
            wx.MessageBox("Please enter a positive integer number", "Error", wx.OK | wx.ICON_ERROR)
            self.N_time.Clear()

    def plot_info(self, d, i):
        x = ["0", "1"]
        y = [(len(d) - d.sum()) / len(d), d.sum() / len(d)]
        self.info_fig.clear()
        ax = self.info_fig.add_subplot(1, 1, 1)
        ax.bar(x, y, facecolor="deeppink", edgecolor="deeppink")
        ax.set_title(f"Generated {len(d) * (i + 1)} random numbers")
        self.info_canvas.draw()

    def plot_img(self, data):
        self.img_fig.clear()
        ax = self.img_fig.add_subplot(1, 1, 1)
        ax.clear()
        ax.imshow(data, cmap="gray")
        ax.axis("off")
        self.img_canvas.draw()

    def run(self, evt):
        if self.image.IsEmpty():
            # self.image_id = 0
            self.image_id = np.random.randint(0, 9999)
            self.image.Clear()
            self.image.AppendText(str(self.image_id))
            self.Da_to_test = self.data[self.image_id]
            self.Label_to_test = int(self.label[self.image_id])
            self.plot_img(self.Da_to_test)
            self.image_label.Clear()
            self.image_label.AppendText(str(self.Label_to_test))
        self.gauge.SetRange(self.ens)
        self.log_text_ctrl.Clear()
        self.log_text_ctrl.AppendText("The program running settings as follows:\n\n")
        self.log_text_ctrl.AppendText(f"The image ID is {self.image_id} (0 for default).\t Confirmed!!!\n\n")
        self.log_text_ctrl.AppendText("RUNNING...\n \n")

        start_time = time.time()

        # random_data = []
        # for i in range(self.ens):
        #     # 1. 产生足够的随机数
        #     # 2. 输入随机数到RRAM程序
        #     # 3. 运行RRAM程序
        #     # 4. 输出程序运行信息
        #     # 5. 将输出程序打印到窗口
        #     d = np.random.randint(0, 2, (900 * 8 + 64 * 8 + 1 * 10) * 10)
        #     self.plot_info(d)
        #     random_data.append(d)
        #     self.gauge.SetValue(i+1)
        #     # rn = random()
        #     # res = Control(self.Da_to_test, rn)
        #     # self.log_text_ctrl.AppendText(f"The result is {res}. \n\n")
        #     # self.log_text_ctrl.AppendText(f"The result is {wx.DateTime.Now().FormatTime()}. \n\n")
        #     self.log_text_ctrl.AppendText(f"Random Number ID: {i}, Time {wx.DateTime.Now().FormatTime()}. \n\n")
        # random_data = np.concatenate(random_data, axis=0)

        # load random_data
        true_random_data = np.load('tdc/random_data.npy', allow_pickle=True)
        piece_num = (900 * 8 + 64 * 8 + 1 * 10) * 10
        num = piece_num * self.ens
        index = random.randint(0, len(true_random_data) - num)
        random_data = true_random_data[index: index + num]
        for i in range(self.ens):
            time.sleep(3)
            d = random_data[i * piece_num: (i + 1) * piece_num]
            self.plot_info(d, i)
            self.gauge.SetValue(i + 1)
            # self.log_text_ctrl.AppendText(f"Random Number ID: {i}, Time {wx.DateTime.Now().FormatTime()}. \n\n")
            self.log_text_ctrl.AppendText(f"Random Number ID: {i}.\n\n")

        print(random_data.shape)
        self.log_text_ctrl.AppendText(":D\n\n")

        self.pred.Clear()
        self.uncer.Clear()
        self.ale.Clear()
        self.eps.Clear()
        self.pred.AppendText('')
        self.uncer.AppendText('')
        self.ale.AppendText('')
        self.eps.AppendText('')

        # fit_factors = list(np.load('fit_factors.npy', allow_pickle=True))
        fit_factors = list(np.load('fit_factors.npy', allow_pickle=True))
        # fit_factors = [None] * 14
        with Control() as control:
            # for i in [3, 4, 5, 6, 7, 8]:
            #     fit_factors[i] = None
            outputs, res = self.process.forward(False,
                                            np.expand_dims(self.Da_to_test, axis=0),  # Image
                                            self.ens, # num
                                            self.Label_to_test,
                                            control=control,
                                            fit_params=fit_factors,
                                            random_data=random_data,
                                            return_out_only=True
                                 )
        # 1、计算预测的标签以及不确定性
        pred = np.argmax(outputs, axis=1).item()
        print(pred)

        # un, ale, eps = unc(res)
        T = 10
        normalized = False
        # (T, c)
        net_out = np.transpose(res[0], (1, 0))
        net_out = torch.as_tensor(net_out)
        if normalized:
            prediction = F.softplus(net_out)
            p_hat = prediction / torch.sum(prediction, dim=1).unsqueeze(1)
        else:
            p_hat = F.softmax(net_out, dim=1)
        p_hat = p_hat.detach().cpu().numpy()
        p_bar = np.mean(p_hat, axis=0)

        temp = p_hat - np.expand_dims(p_bar, 0)
        # (c, T) @ (T, c)
        epistemic = np.dot(temp.T, temp) / T
        epistemic = np.diag(epistemic)

        aleatoric = np.diag(p_bar) - (np.dot(p_hat.T, p_hat) / T)
        aleatoric = np.diag(aleatoric)

        print(epistemic, aleatoric)
        print(epistemic[pred], aleatoric[pred])

        # 2、将标签以及不确定性打印到窗口
        self.pred.AppendText(str(pred))
        # self.uncer.AppendText(f"{aleatoric[pred] + epistemic[pred]:.7f}")
        # self.ale.AppendText(f"{aleatoric[pred]:.7f}")
        # self.eps.AppendText(f"{epistemic[pred]:.7f}")
        self.uncer.AppendText(f"{aleatoric[pred] + epistemic[pred]:.3e}")
        self.ale.AppendText(f"{aleatoric[pred]:.3e}")
        self.eps.AppendText(f"{epistemic[pred]:.3e}")
        end_time = time.time()
        self.log_text_ctrl.AppendText(f"The inference times is {end_time - start_time:.3f} s.\t Confirmed!!!\n\n")
        self.log_text_ctrl.AppendText("The program ran successfully and ended!!!\n\n")


if __name__ == "__main__":
    app = wx.App()
    frame = MainFrame(None)
    frame.Show()
    app.MainLoop()
