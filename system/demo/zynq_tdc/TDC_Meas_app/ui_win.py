#!/usr/bin/python3
# -*- coding: utf-8 -*-
import os
import csv
import json
from PyQt5.QtWidgets import (
    QWidget,
    QPushButton,
    QDesktopWidget,
    QComboBox,
    QHBoxLayout,
    QVBoxLayout,
    QGridLayout,
    QLineEdit,
    QLabel,
    QFileDialog,
    QMessageBox,
)

from PyQt5.QtGui import QIcon, QDoubleValidator
from PyQt5 import QtCore
from PyQt5.QtCore import QTimer
from SocketThread import sys_status
import matplotlib.pyplot as plt
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas

# from random import randint
# from SocketThread import sys_status
from calib_lookup import ProcessTDCMeas

#  command format : {"index":2,"volt_ref":3.12,"start":1,"protocol":0}
#  reponse format：{"index":2,"status":0}
global start_point
start_point = 0


class CQtUI(QWidget):
    def __init__(self, cmd_queue, recv_queue):
        super().__init__()
        self.time_threshold = 0.0
        self.calib_file_flag = True
        self.initUI()
        self.cmd_queue = cmd_queue
        self.recv_queue = recv_queue
        self.read_params_fromfile()  # 初始化参数
        # 更新日志，textBrower
        self.logstart_point = 0
        self.timer = QTimer(self)  # 初始化一个定时器
        self.timer.timeout.connect(self.update_status)
        # self.timer.timeout.connect(
        #     self.update_text_browser)  # 计时结束调用operate()方法
        self.timer.start(600)  # 设置计时间隔并启动,ms

        self.timer_graph = QTimer(self)  # 初始化一个定时器
        self.timer_graph.timeout.connect(self.update_graph)
        # self.timer.timeout.connect(
        #     self.update_text_browser)  # 计时结束调用operate()方法
        self.timer_graph.start(500)  # 设置计时间隔并启动,ms

    # 从文件中获取参数

    def read_params_fromfile(self):
        filename = "params.json"
        if os.path.exists(filename):
            f = open(filename, "r")
            content = f.read()
            self.params = json.loads(content)
            print(self.params)
            f.close()
        else:
            self.params = {
                "index": 0,
                "volt_ref": 0.12,
                "start": 0,
                "protocol": 0,
                "odd": 100,
                "odd_unit": "ns",
                "time_th": 0.1,
                "filepath": "C:/",
            }
            b = json.dumps(self.params)
            f2 = open(filename, "w")
            f2.write(b)
            f2.close()
        # 拆分：参数
        self.params["index"] = 0
        self.filepath = self.params["filepath"]
        self.cmd_params = self.params
        self.cmd_params.pop("filepath")
        # 更新EditLine
        self.ref_volt_Edit.setText(str(self.cmd_params["volt_ref"]))
        self.time_threshold_editior.setText(str(self.cmd_params["time_th"]))
        # self.odd_Edit.setText(str(self.cmd_params['odd']))
        self.file_path_Edit.setText(self.filepath)
        sys_status.tdc_store_dir = self.filepath
        if self.cmd_params["odd_unit"] == "1ns":
            self.time_unit.setCurrentIndex(1)
        else:
            self.time_unit.setCurrentIndex(0)
        # send to zynq
        self.cmd_params["start"] = 0
        self.update_params2zynq(1)
        # process data
        self.proc = ProcessTDCMeas(self.filepath, None)
        if self.cmd_params["odd_unit"] == "100ps":
            self.proc.set_paritymode(100)
        else:
            self.proc.set_paritymode(1000)

    def update_params2zynq(self, send_flag, filename="params.json"):
        self.cmd_params["index"] += 1
        if send_flag:
            cmd_str = json.dumps(self.cmd_params)
            self.cmd_queue.put(cmd_str)
        self.params = self.cmd_params
        self.params["filepath"] = self.filepath
        b = json.dumps(self.params)
        f2 = open(filename, "w")
        f2.write(b)
        f2.close()

    def update_text_browser(self):
        fo = open("app.log", "rb")  # 一定要用'rb'因为seek 是以bytes来计算的
        fo.seek(self.logstart_point, 1)  # 移动文件读取指针到指定位置
        for line in fo.readlines():
            self.msg_text_browser.append(str(line.decode()))
        self.msg_text_browser.moveCursor(self.msg_text_browser.textCursor().End)  # 文本框显示到底部
        # 输出后的指针位置赋值给start_piont
        self.logstart_point = fo.tell()
        fo.close()

    def update_odd_unit(self):
        if self.time_unit.currentIndex() == 0:
            self.cmd_params["odd_unit"] = "100ps"
        else:
            self.cmd_params["odd_unit"] = "1ns"
        self.update_params2zynq(0)

    def update_odd_vaule(self):
        if self.odd_Edit.isModified():
            self.cmd_params["odd"] = float(self.odd_Edit.text())
            self.update_params2zynq(0)
        self.odd_Edit.setModified(False)

    def update_ref_volt(self):
        if self.ref_volt_Edit.isModified():
            self.cmd_params["volt_ref"] = float(self.ref_volt_Edit.text())
            self.update_params2zynq(1)

        self.ref_volt_Edit.setModified(False)

    def update_status(self):
        global sys_status
        if sys_status.data_socket_conn_state and sys_status.cmd_socket_conn_state:
            self.status.setText("Connected to Zynq serve!!!")
        else:
            self.status.setText("Connection failure!!!")

    def update_filepath_edit(self):
        global sys_status
        if self.file_path_Edit.isModified():
            self.filepath = self.file_path_Edit.text()
            sys_status.tdc_store_dir = self.filepath
            self.update_params2zynq(0)
        self.file_path_Edit.setModified(False)
        # print(self.filepath)

    def update_threshold_edit(self):
        if self.time_threshold_editior.isModified():
            self.time_threshold = float(self.time_threshold_editior.text())
            # print(self.time_threshold)
            self.cmd_params["time_th"] = self.time_threshold
            self.update_params2zynq(0)
        self.time_threshold_editior.setModified(False)
        # print(self.time_threshold)

    def initUI(self):

        self.setWindowTitle("Neuronal Time Delay Measurement System")
        self.setWindowIcon(QIcon("icon.ico"))
        self.setStyleSheet("""QPushButton{font-size:20px;}""")
        self.setStyleSheet("""QLabel{font-size:15px;}""")
        self.setStyleSheet("""QComboBox{font-size:15px;}""")
        self.setStyleSheet("""QLineEdit{font-size:15px;}""")

        self.start_btn = QPushButton("Start")
        stop_button = QPushButton("Stop")
        # start_button.setFixedWidth(200)

        # stop_button.setFixedWidth(200)
        self.start_btn.clicked.connect(self.StartbuttonClicked)
        stop_button.clicked.connect(self.StopbuttonClicked)

        path_button = QPushButton("ChooseFolder")
        # path_button.setFixedHeight(25)
        path_button.clicked.connect(self.PathButtonClicked)
        h_layout = QVBoxLayout()  # 最顶层
        hlayout_button = QHBoxLayout()
        grid = QGridLayout()  # 栅格布局
        grid.setVerticalSpacing(15)
        # grid.setHorizontalSpacing(40)
        self.ref_volt_Edit = QLineEdit()
        self.ref_volt_Edit.setFixedWidth(50)
        self.ref_volt_Edit.setValidator(QDoubleValidator())  # 只允许输入浮点数
        self.ref_volt_Edit.setAlignment(QtCore.Qt.AlignRight)
        self.ref_volt_Edit.editingFinished.connect(self.update_ref_volt)
        grid.rowStretch(1)
        grid.addWidget(QLabel("RefVolt:"), 1, 0, QtCore.Qt.AlignRight)
        grid.addWidget(self.ref_volt_Edit, 1, 1, QtCore.Qt.AlignLeft)
        grid.addWidget(QLabel("mV"), 1, 2, QtCore.Qt.AlignLeft)
        grid.addWidget(QLabel("ParityUnit:"), 1, 3)
        self.time_unit = QComboBox(self)
        self.time_unit.addItem("100ps")
        self.time_unit.addItem("1ns")
        grid.addWidget(self.time_unit, 1, 4)
        # self.time_unit.resize(50, 50)
        self.time_unit.activated[str].connect(self.onActivated)
        # self.time_unit.setFixedSize(120, 38)
        # .setFixedHeight(25)
        self.time_unit.currentIndexChanged.connect(self.update_odd_unit)

        path_label = QLabel("Location:")
        grid.addWidget(path_label, 1, 5, QtCore.Qt.AlignRight)
        self.file_path_Edit = QLineEdit()
        self.file_path_Edit.setAlignment(QtCore.Qt.AlignLeft)
        grid.addWidget(self.file_path_Edit, 1, 6)
        # self.file_path_Edit.setFixedSize(400, 38)
        self.file_path_Edit.setFixedWidth(100)
        grid.addWidget(path_button, 1, 7)
        self.file_path_Edit.editingFinished.connect(self.update_filepath_edit)

        grid.addWidget(QLabel("Threshold:"), 1, 8, QtCore.Qt.AlignRight)
        self.time_threshold_editior = QLineEdit()
        self.time_threshold_editior.setFixedWidth(50)
        self.time_threshold_editior.setValidator(QDoubleValidator())  # 只允许输入浮点数
        self.time_threshold_editior.setAlignment(QtCore.Qt.AlignRight)
        self.time_threshold_editior.editingFinished.connect(self.update_threshold_edit)
        grid.addWidget(self.time_threshold_editior, 1, 9, QtCore.Qt.AlignRight)
        grid.addWidget(QLabel("ns"), 1, 10, QtCore.Qt.AlignRight)

        h_layout1 = QVBoxLayout()
        # h_layoutempty = QVBoxLayout()
        h_layout1.addWidget(self.start_btn, QtCore.Qt.AlignCenter)
        # h_layout1.addWidget(stop_button, QtCore.Qt.AlignLeft)
        hlayout_button.addLayout(grid)
        hlayout_button.addStretch(1)
        hlayout_button.addLayout(h_layout1)
        # hlayout_button.addStretch(1)

        # h_layout1 = QHBoxLayout()
        # h_layout1.addStretch(1)
        # h_layout1.addWidget(start_button)
        # h_layout1.addWidget(stop_button)
        # h_layout1.addStretch(1)

        # 底部状态栏
        h_layout2 = QVBoxLayout()
        self.status = QLabel(" ")
        h_layout2.addWidget(self.status, QtCore.Qt.AlignLeft)
        self.status.setFixedHeight(20)
        self.status.setAlignment(QtCore.Qt.AlignLeft)
        # h_layout2.addWidget(QLabel('已生成文件数：11112'))
        # h_layout2.addWidget(QLabel('测量总数：11112'))
        # h_layout2.addWidget(QPushButton('复位'))

        # h_layout.addLayout(grid)
        # h_layout.addLayout(button_H_2)
        # h_layout.addLayout(button_H_1)
        # h_layout.setSpacing(30)
        h_layout.addLayout(hlayout_button)
        # self.msg_text_browser = QTextBrowser(self)
        # h_layout.setSpacing(30)
        # h_layout.addWidget(self.msg_text_browser)
        # h_layout.addLayout(h_layout2)
        # 创建一个Matplotlib图形实例，并将其绑定到PyQt的窗口部件
        fig_layout = QHBoxLayout()
        self.fig_1, self.ax_1 = plt.subplots(figsize=(4, 4))
        self.canvas_1 = FigureCanvas(self.fig_1)
        self.ax_1.set_title("Parity")
        fig_layout.addWidget(self.canvas_1)

        self.fig_2, self.ax_2 = plt.subplots(figsize=(4, 4))
        self.canvas_2 = FigureCanvas(self.fig_2)
        self.ax_2.set_title("Times")
        self.ax_2.set_xlabel("Time/ns")
        self.ax_2.set_ylabel("Counts")
        fig_layout.addWidget(self.canvas_2)
        h_layout.addLayout(fig_layout)
        # end of plot
        # h_layout.addStretch(1)
        h_layout.addLayout(h_layout2)
        self.setLayout(h_layout)
        self.center()
        self.show()

    def update_parity(self, sizes):
        self.ax_1.cla()  # 删除原图，让画布上只有新的一次的图
        labels = ["0", "1"]
        self.ax_1.pie(sizes, labels=labels, autopct="%.1f%%")
        self.ax_1.set_title("Parity")
        self.canvas_1.draw()

    def update_tdc_meas(self, data):
        self.ax_2.cla()  # 删除原图，让画布上只有新的一次的图
        # heights = [randint(0, 100) for i in range(5)]
        # labels = ["A", "B", "C", "D", "E"]
        self.ax_2.set_xlabel("Time/ns")
        self.ax_2.set_ylabel("Counts")
        # self.ax_2.bar(labels, heights)
        plt.hist(data, color="skyblue", alpha=0.8)
        self.ax_2.set_title("Times")
        self.canvas_2.draw()

    def update_graph(self):
        # self.update_graph_calibbyPython()
        # self.update_graph_calibbyFPGA()
        self.update_graphfile_calibbyFPGA()

    def update_graphfile_calibbyFPGA(self):
        """update graph and file"""
        global sys_status
        while not self.recv_queue.empty():
            if self.calib_file_flag:
                self.calib_file_flag = False
                continue
            filename = self.recv_queue.get()
            times = []
            odd = [0, 0]
            with open(filename, mode="r") as infile:
                csv_reader = csv.reader(infile)
                header = next(csv_reader)
                data = [row for row in csv_reader]
            header = ["times", "odd", "odd_th"]
            with open(filename, newline="", mode="w") as csvfile:
                csv_writer = csv.writer(csvfile)
                csv_writer.writerow(header)
                for row in data:
                    # rows = row[0].split(',')
                    if self.cmd_params["odd_unit"] == "100ps":
                        t = int(int(row[0]) / 100)
                    else:
                        t = int(int(row[0]) / 1000)
                    t_ns = int(int(row[0]) / 1000)
                    times.append(t)
                    odd[int(t & 1)] += 1
                    csv_writer.writerow([t, int(t & 1), int(t_ns > self.cmd_params["time_th"])])
            self.update_parity(odd)
            self.update_tdc_meas(times)

    def update_graph_calibbyFPGA(self):
        global sys_status
        while not self.recv_queue.empty():
            # print(sys_status.cali_filename)
            # self.proc.update_calibfile(sys_status.cali_filename)
            # self.proc.set_paritymode(1)  # TODO : delete
            filename = self.recv_queue.get()
            # outfilename = self.proc.process_tdc_meas_file(filename)
            times = []
            odd = [0, 0]
            with open(filename, newline="") as csvfile:
                spamreader = csv.reader(csvfile, delimiter=" ", quotechar="|")
                for i, row in enumerate(spamreader):
                    if i == 0:
                        continue
                    # rows = row[0].split(',')
                    if self.cmd_params["odd_unit"] == "100ps":
                        t = int(int(row[0]) / 100)
                    else:
                        t = int(int(row[0]) / 1000)
                    times.append(t)
                    odd[int(t & 1)] += 1
            self.update_parity(odd)
            self.update_tdc_meas(times)

    def update_graph_calibbyPython(self):
        global sys_status
        while not self.recv_queue.empty():
            # print(sys_status.cali_filename)
            self.proc.update_calibfile(sys_status.cali_filename)
            # self.proc.set_paritymode(1)  # TODO : delete
            filename = self.recv_queue.get()
            outfilename = self.proc.process_tdc_meas_file(filename)
            times = []
            odd = [0, 0]
            with open(outfilename, newline="") as csvfile:
                spamreader = csv.reader(csvfile, delimiter=" ", quotechar="|")
                for i, row in enumerate(spamreader):
                    if i == 0:
                        continue
                    rows = row[0].split(",")
                    times.append(int(rows[0]))
                    odd[int(rows[1])] += 1
            self.update_parity(odd)
            self.update_tdc_meas(times)

    def center(self):
        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())

    def StartbuttonClicked(self):
        # send parameter to queue
        global sys_status
        if sys_status.data_socket_conn_state and sys_status.cmd_socket_conn_state:
            # if True:
            sys_status.start_measurement = 1
            self.cmd_params["index"] += 1
            if self.cmd_params["start"] == 0:
                self.cmd_params["start"] = 1
                self.start_btn.setText("Stop")
            else:
                self.cmd_params["start"] = 0
                self.start_btn.setText("Start")
            cmd_str = json.dumps(self.cmd_params)
            print(cmd_str)
            self.cmd_queue.put(cmd_str)
        else:
            box = QMessageBox()
            box.setText("Connection failure!!!")
            box.setWindowTitle("ERROR")
            box.addButton("Yes", QMessageBox.YesRole)
            box.exec_()
            # print( self.cmd_queue.get())
        # print('Start button clicked')

    def StopbuttonClicked(self):
        global sys_status
        sys_status.start_measurement = 0
        self.cmd_params["index"] += 1
        self.cmd_params["start"] = 0
        cmd_str = json.dumps(self.cmd_params)
        self.cmd_queue.put(cmd_str)

    def PathButtonClicked(self):
        global sys_status
        path_store_data = QFileDialog.getExistingDirectory(self, "Open Folder")
        if path_store_data == "":
            print("\n取消选择")
        else:
            self.filepath = path_store_data
            sys_status.tdc_store_dir = self.filepath
            self.file_path_Edit.setText(self.filepath)
            self.proc = ProcessTDCMeas(self.filepath, None)
            if self.cmd_params["odd_unit"] == "100ps":
                self.proc.set_paritymode(100)
            else:
                self.proc.set_paritymode(1000)
            self.update_params2zynq(0)

    def onActivated(self, text):
        print("onActivated clicked")
