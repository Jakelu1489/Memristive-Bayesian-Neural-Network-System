#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
# import re
# 文件名形如：1.csv，2.csv等等
global filename_cnt
global filename_cnt_calib
filename_cnt = 1
filename_cnt_calib = 1

global calib_filename


# def new_file_name(test_dir):
#     global filename_cnt
#     while 1:
#         filename = str(filename_cnt)+".csv"
#         if os.path.exists(filename):
#             filename_cnt = filename_cnt + 1
#         else:
#             return filename
def new_file_name(test_dir):
    global filename_cnt
    global calib_filename
    while 1:
        filename = str(filename_cnt)+'_'+calib_filename
        filename_all = os.path.join(test_dir, filename).replace('\\', '/')
        if os.path.exists(filename_all):
            filename_cnt = filename_cnt + 1
        else:
            return filename_all


def new_file_name_calib(test_dir):
    global filename_cnt_calib
    global calib_filename
    while 1:
        filename = "calib_"+str(filename_cnt_calib)+".csv"
        filename_all = os.path.join(test_dir, filename).replace('\\', '/')
        if os.path.exists(filename_all):
            filename_cnt_calib = filename_cnt_calib + 1
        else:
            calib_filename = filename
            return filename_all
