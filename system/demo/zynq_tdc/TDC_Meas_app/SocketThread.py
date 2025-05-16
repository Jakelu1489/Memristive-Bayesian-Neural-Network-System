#!/usr/bin/python3
# -*- coding: utf-8 -*-

# 1、导⼊ socket 模块
import json
import socket
import time
import threading
from queue import Queue
import thread_exit
import logging
import get_filename
import csv
import os

logger = logging.getLogger(__name__)

CMD_PORT = 1000
DATA_PORT = 2000
SERVER_IP = "192.168.1.1"
cmd_queue_from_ui = Queue(100)
meas_file_queue_toui = Queue(100)


global sys_status


class SysStatus:
    def __init__(self):
        self.cmd_socket_conn_state = 0
        self.data_socket_conn_state = 0
        self.tdc_store_dir = ""
        self.start_measurement = 0
        self.cali_mode = False
        self.cali_finished = False
        self.cali_filename = None


sys_status = SysStatus()


# 接收线程
class recieve(threading.Thread):
    def __init__(self, socket):
        threading.Thread.__init__(self)
        self.socket = socket

    def run(self):
        global sys_status
        while not thread_exit.is_exit:
            time.sleep(1)
            try:
                data = self.socket.recv(1024).decode("utf-8")
                reponse = json.loads(data)
                print(reponse)
                if reponse["status"] == 2:
                    sys_status.cali_mode = True
                    sys_status.cali_finished = False
                elif reponse["status"] == 3:
                    sys_status.cali_mode = False
                    sys_status.cali_finished = True
            except Exception as e:
                print("reponse exception", e)
                break


class CMDSocketThread(threading.Thread):
    def __init__(self, cmd_queue):
        global sys_status
        sys_status.cmd_socket_conn_state = 0  # 连接状态
        threading.Thread.__init__(self)
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.cmd_queue = cmd_queue

    def run(self):
        conn = 1
        global sys_status
        while not thread_exit.is_exit:
            try:
                self.socket.connect((SERVER_IP, CMD_PORT))
                print("CMD_PORT连接成功")
                data_recv = recieve(self.socket)
                data_recv.start()
                sys_status.cmd_socket_conn_state = 1
                break
            except socket.error:
                print("CMD_PORT无连接")
                sys_status.cmd_socket_conn_state = 0
                time.sleep(1)

        while not thread_exit.is_exit:
            # cmd = input("请输入命令：")

            while not self.cmd_queue.empty():
                cmd_str = str(self.cmd_queue.get())
                logger.info(cmd_str)
                try:
                    self.socket.sendall(cmd_str.encode("utf-8"))
                except Exception as e:  # 断开连接
                    print("CMD Socket disconnected")
                    conn = 0
                    self.socket.close()
                    time.sleep(1)
                    while not thread_exit.is_exit:
                        try:
                            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                            data_recv = recieve(self.socket)
                            data_recv.start()
                        except:
                            print("CMD_PORT无连接,重连接中")
                            time.sleep(1)
                    self.cmd_queue.task_done()
                    break
            time.sleep(1)

        self.socket.close()


def list_to_hex_string(list_data):
    list_str = "[ "
    for x in list_data:
        list_str += "0x{:02X},".format(x)
    list_str += " ]"
    return list_str


def processs_tdc_data(data):
    if len(data) == 0:
        # print("error recv length1")
        return None
    if len(data) % 8 != 0:
        # print("error recv length2")
        return None
    timestamps = []
    for i in range(len(data) >> 3):
        timestamp = []
        timestamp.append(data[i * 8] | data[i * 8 + 1] << 8 | data[i * 8 + 2] << 16 | data[i * 8 + 3] << 24)  # start
        timestamp.append(
            data[i * 8 + 4] | data[i * 8 + 5] << 8 | data[i * 8 + 6] << 16 | data[i * 8 + 7] << 24
        )  # stop
        timestamps.append(timestamp)

    return timestamps


def processs_tdc_data_withcalibed(data):
    if len(data) == 0:
        # print("error recv length1")
        return None
    if len(data) % 8 != 0:
        # print("error recv length2")
        return None
    timestamps = []
    for i in range(len(data) >> 3):
        timestamp = []
        timestamp.append(data[i * 8] | data[i * 8 + 1] << 8 | data[i * 8 + 2] << 16 | data[i * 8 + 3] << 24)  # times
        timestamps.append(timestamp)

    return timestamps


class DATASocketThread(threading.Thread):
    def __init__(self, file_queue):
        threading.Thread.__init__(self)
        global sys_status
        sys_status.data_socket_conn_state = 0
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.settimeout(5)
        self.tdc_recv_buffer = []
        self.started = False  # 是否接收过数据
        self.file_queue = file_queue

    def run(self):
        self.runCalibbyFPGA()
        # self.runcalibedByPC()

    def runCalibbyFPGA(self):
        global sys_status
        while not thread_exit.is_exit:
            try:
                self.socket.connect((SERVER_IP, DATA_PORT))
                print("DATA_PORT connected")
                sys_status.data_socket_conn_state = 1
                break
            except socket.error:
                print("DATA_PORT connection failed")
                sys_status.data_socket_conn_state = 0
                time.sleep(1)
        while not thread_exit.is_exit:
            while len(sys_status.tdc_store_dir) == 0:
                time.sleep(1)
                if thread_exit.is_exit:
                    break

            self.started = False

            if not sys_status.cali_finished:
                filename = get_filename.new_file_name_calib(sys_status.tdc_store_dir)
                sys_status.cali_filename = filename
            else:
                filename = get_filename.new_file_name(sys_status.tdc_store_dir)

            print(filename)
            with open(filename, "w", newline="") as fp:
                writer = csv.writer(fp)
                writer.writerow(["timestamp"])
                self.tdc_recv_buffer = []
                while not thread_exit.is_exit:
                    try:
                        recv_data = self.socket.recv(1024)
                        if recv_data is not None:
                            if len(recv_data) > 0:
                                self.tdc_recv_buffer += recv_data
                                csv_rows = processs_tdc_data_withcalibed(self.tdc_recv_buffer)
                                # print("recv size is ", len(
                                #     self.tdc_recv_buffer))
                                if csv_rows is not None:
                                    writer.writerows(csv_rows)
                                    self.tdc_recv_buffer = []
                                elif len(recv_data) == 0:
                                    self.tdc_recv_buffer = []
                                self.started = True
                                # print(type(self.tdc_recv_buffer[0]))
                    except socket.timeout:  # 单次测量结束，等待下次开始
                        print("recv data timeout")
                        if self.started:
                            print("store to file: " + filename)
                            self.file_queue.put(filename)
                            break
                # 删除空文件
            if not self.started:
                os.remove(filename)
            self.started = False
        self.socket.close()

    def runcalibedByPC(self):
        global sys_status
        while not thread_exit.is_exit:
            try:
                self.socket.connect((SERVER_IP, DATA_PORT))
                print("DATA_PORT connected")
                sys_status.data_socket_conn_state = 1
                break
            except socket.error:
                print("DATA_PORT connection failed")
                sys_status.data_socket_conn_state = 0
                time.sleep(1)
        while not thread_exit.is_exit:
            while len(sys_status.tdc_store_dir) == 0:
                time.sleep(1)
                if thread_exit.is_exit:
                    break

            self.started = False

            if not sys_status.cali_finished:
                filename = get_filename.new_file_name_calib(sys_status.tdc_store_dir)
                sys_status.cali_filename = filename
            else:
                filename = get_filename.new_file_name(sys_status.tdc_store_dir)

            print(filename)
            with open(filename, "w", newline="") as fp:
                writer = csv.writer(fp)
                writer.writerow(["start", "stop"])
                self.tdc_recv_buffer = []
                while not thread_exit.is_exit:
                    try:
                        recv_data = self.socket.recv(1024)
                        if recv_data is not None:
                            if len(recv_data) > 0:
                                self.tdc_recv_buffer += recv_data
                                csv_rows = processs_tdc_data(self.tdc_recv_buffer)
                                # print("recv size is ", len(
                                #     self.tdc_recv_buffer))
                                if csv_rows is not None:
                                    writer.writerows(csv_rows)
                                    self.tdc_recv_buffer = []
                                elif len(recv_data) == 0:
                                    self.tdc_recv_buffer = []
                                self.started = True
                                # print(type(self.tdc_recv_buffer[0]))
                    except socket.timeout:  # 单次测量结束，等待下次开始
                        print("recv data timeout")
                        if self.started:
                            print("store to file: " + filename)
                            self.file_queue.put(filename)
                            break
                # 删除空文件
            if not self.started:
                os.remove(filename)
            self.started = False
        self.socket.close()
