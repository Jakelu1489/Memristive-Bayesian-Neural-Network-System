#!/usr/bin/python3
# -*- coding: utf-8 -*-

from multiprocessing import Process, Pool
import csv
import os
import numpy as np
from collections import deque

# filename = './calib_1.csv'


class MedianFilter:
    def __init__(self, kernel_size):
        if kernel_size % 2 == 0:
            raise ValueError("kernel_size must be an odd number")
        self.kernel_size = kernel_size
        self.buffer = deque(maxlen=kernel_size)
        self.k = kernel_size // 2

    def add_data(self, value):
        self.buffer.append(value)
        if len(self.buffer) == self.kernel_size:
            return self.median_filter()
        else:
            return None

    def median_filter(self):
        sorted_buffer = sorted(self.buffer)
        return sorted_buffer[self.k]


class calibProcess:
    def __init__(self):
        self.max_delay_length = 192
        self.clock_period = 1e6/350.0  # units: ps
        self.calib_meas_num = 0
        self.start_lookup = None
        self.stop_lookup = None

    def timestamp_sparse(self, timestmap):
        fine = timestmap & 0x000000ff
        coarse = (timestmap & 0xffffff00) >> 8
        return [coarse, fine]

    def fine_time_to_histogram(self, fine_time_list):
        hist = [0]*self.max_delay_length
        for item in fine_time_list:
            hist[item-1] += 1
        self.calib_meas_num = sum(hist)
        return hist

    def calib_lookup_gen(self, time_fine_list):
        hist = self.fine_time_to_histogram(time_fine_list)
        W = [ht*self.clock_period/self.calib_meas_num for ht in hist]
        look_up = []
        W_sum = 0
        for i, item in enumerate(W):
            T = W_sum + W[i]/2
            look_up.append(T)
            W_sum += W[i]
        return look_up

    def process(self, filename):
        with open(filename, newline='') as csvfile:
            spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
            header_flag = False
            timestamp_list = []
            for row in spamreader:
                if not header_flag:
                    header_flag = True
                    continue
                timestamps = row[0].split(',')
                timestamps = [self.timestamp_sparse(
                    int(ts)) for ts in timestamps]
                timestamp_list.append(timestamps)
        start_delay_fine = [ts[0][1] for ts in timestamp_list]
        stopdelay_fine = [ts[1][1] for ts in timestamp_list]
        self.start_lookup = self.calib_lookup_gen(start_delay_fine)
        self.stop_lookup = self.calib_lookup_gen(stopdelay_fine)
        print("lookup table generated")
        # store to csv file 
        # with open('lookup_start.csv', 'w', newline='') as fp:
        #     writer = csv.writer(fp)
        #     writer.writerow(self.start_lookup)
        # with open('lookup_stop.csv', 'w', newline='') as fp:
        #     writer = csv.writer(fp)
        #     writer.writerow(self.stop_lookup)
        # print(self.start_lookup)
        # print(self.start_lookup)
        # return self.start_lookup, self.stop_lookup
        # # start_timestamp = int(timestamp[0])
        # # stop_timestamp = int(timestamp[1])
        # # start_timestamp_fine = start_timestamp &
        # break
        # print(timestamp_list)
        # # print([start, stop])
#         # # print(', '.join(row))
# calib_p = calibProcess()
# calib_p.process(filename)
# # print(calib_p.clock_period)


class ProcessTDCMeas(calibProcess):
    def __init__(self, calib_filename, queue):
        super(ProcessTDCMeas, self).__init__()
        self.calib_filename = os.path.basename(calib_filename)
        self.dir = os.path.dirname(calib_filename)
        self.file_cnt_tdc = 1
        self.queue = queue
        self.clock_period = 1e6/350
        self.odd = 100  # 100ps
        self.offset = 0
        
        

    def set_paritymode(self, unit):
        self.odd = unit

    def get_filename(self):
        filename = os.path.join(self.dir, str(
            self.file_cnt_tdc)+'_'+self.calib_filename)
        if os.path.exists(filename):
            self.file_cnt_tdc += 1
            return filename
        else:
            return None

    def timestamp_ps(self, start_stop_times):
        # start_time_sp = [super(ProcessTDCMeas, self).timestamp_sparse(
        #     start_stop_times[0][0]), super(ProcessTDCMeas, self).timestamp_sparse(
        #     start_stop_times[0][1])]  # [coarse, fine]
        # print(start_time_sp)
        # stop_time_sp = [super(ProcessTDCMeas, self).timestamp_sparse(
        #     start_stop_times[1][0]), super(ProcessTDCMeas, self).timestamp_sparse(
        #     start_stop_times[1][1])]
        try:
            start_time_ps = start_stop_times[0][0] * self.clock_period - \
                self.start_lookup[start_stop_times[0][1]-1]
            stop_time_ps = start_stop_times[1][0] * self.clock_period - \
                self.stop_lookup[start_stop_times[1][1]-1]
            return start_time_ps, stop_time_ps
        except:
            return None, None

    def times_meas(self, start_ps, stop_ps):
        # self.offset = 0
        return stop_ps - start_ps - self.offset

    def cal_odd(self, time_meas):
        # print("self.odd", self.odd)
        return round(time_meas/self.odd) % 2

    def calib_lookup_cal(self):
        super(ProcessTDCMeas, self).process(
            os.path.join(self.dir, self.calib_filename))

    def process_tdc(self, file_path,  out_filename):
        tdc_meas_all = []
        filter = MedianFilter(kernel_size=3)
        with open(out_filename, 'w', newline='') as fp:
            writer = csv.writer(fp)
            writer.writerow(['times', 'odd'])
            with open(file_path, 'r', newline='') as csvfile:
                spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
                for i, row in enumerate(spamreader):
                    if i == 0:
                        continue
                    elif i >= 200000:
                        break
                    timestamps = row[0].split(',')
                    timestamps = [self.timestamp_sparse(
                        int(ts)) for ts in timestamps]
                    # print(timestamps)

                    start_time_ps, stop_time_ps = self.timestamp_ps(timestamps)
                    if start_time_ps is None or stop_time_ps is None:
                        continue
                    time_meas = self.times_meas(
                        start_time_ps, stop_time_ps)

                    # if (time_meas <= -1000):
                    #     continue
                    data = abs(time_meas)
                    result = filter.add_data(data)
                    if result is not None:
                        data = result
                        pass
                    tdc_meas_all.append(data)
                    odd = self.cal_odd(data)
                    # writer.writerow(
                    #     [round(data), odd])
                    writer.writerow(
                        [round(data/self.odd), odd])

                    # print(timestamps)
                    # break
        print(np.mean(tdc_meas_all))
        return np.mean(tdc_meas_all)
        print(np.mean(tdc_meas_all))
        print(np.std(tdc_meas_all))

    def update_calibfile(self, filename):
        self.calib_filename = os.path.basename(filename)
        self.dir = os.path.dirname(filename)

    def process_tdc_meas_file(self, file_path):
        if self.start_lookup is None:
            print("No start lookup")
            self.calib_lookup_cal()
            file_name = os.path.basename(self.calib_filename)
            out_filename = os.path.join(os.path.dirname(
                file_path), 'calibed', file_name)
            folder = os.path.exists(os.path.join(os.path.dirname(
                file_path), 'calibed'))
            if not folder:  # 判断是否存在文件夹如果不存在则创建为文件夹
                os.makedirs(os.path.join(os.path.dirname(
                    file_path), 'calibed'))  # makedirs 创建文件时如果路径不存在会创建这个路径
            # print(file_path)
            self.offset = self.process_tdc(file_path,  out_filename)
        print("self.offset", self.offset)
        file_name = os.path.basename(file_path)
        out_filename = os.path.join(os.path.dirname(
            file_path), 'calibed', file_name)
        folder = os.path.exists(os.path.join(os.path.dirname(
            file_path), 'calibed'))
        if not folder:  # 判断是否存在文件夹如果不存在则创建为文件夹
            os.makedirs(os.path.join(os.path.dirname(
                file_path), 'calibed'))  # makedirs 创建文件时如果路径不存在会创建这个路径
        self.process_tdc(file_path,  out_filename)
        return out_filename
