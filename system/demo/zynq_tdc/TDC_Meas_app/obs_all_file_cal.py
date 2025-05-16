import csv
from calib_lookup import ProcessTDCMeas
import os
file_range = range(1, 12)
cailb_filename = './dataset/calib_13.csv'
file_path = './dataset/{}_{}'
output_path = './dataset/output/{}.csv'
odd_mode = 100  # 100ps


proc = ProcessTDCMeas(cailb_filename, None)
proc.set_paritymode(odd_mode)  # 100ps
output_file_name = output_path.format(1)
proc.calib_lookup_cal()
with open(output_file_name, 'a', newline='') as wf:
    writer = csv.writer(wf)
    writer.writerow(['times', 'odd'])
    meas_cnt = 0
    for i in file_range:
        raw_time_file_name = file_path.format(
            i, os.path.basename(cailb_filename))
        print(raw_time_file_name)
        with open(raw_time_file_name, 'r') as f:
            csv_reader = csv.reader(f)
            csv_reader.__next__()  # 跳过头部
            for timestamp in csv_reader:
                # writer.writerow(line.strip().split(','))
                # print(timestamp)
                # timestamps = timestamp.split(',')
                # print(timestamps)
                timestamps = [proc.timestamp_sparse(
                    int(ts)) for ts in timestamp]
                start_time_ps, stop_time_ps = proc.timestamp_ps(timestamps)
                if start_time_ps is None or stop_time_ps is None:
                    continue
                time_meas = proc.times_meas(
                    start_time_ps, stop_time_ps)
                data = abs(time_meas)
                # result = filter.add_data(data)
                # if result is not None:
                #     data = result
                odd = proc.cal_odd(data)
                data = round(data/odd_mode)
                if data > 2000 or data < 300:
                    continue
                writer.writerow([data, odd])
                # print([data, odd])
                meas_cnt += 1
            print(f'{raw_time_file_name} Measure count: {meas_cnt}')
            # lines = f.readlines()
            # for line in lines:
            #     print(line.strip())
