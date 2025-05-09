#!/usr/bin/python3
# -*- coding: utf-8 -*-
import threading
import SocketThread
import ui_win
import signal
import sys
import thread_exit
import logging
logger = logging.getLogger(__name__)
file_handler = logging.FileHandler('app.log', encoding='utf-8', mode='w')
logging.basicConfig(handlers={file_handler},
                    format='%(asctime)s %(threadName)s#%(levelname)s: %(message)s',
                    datefmt='%y%m%d %H:%M:%S',
                    level=logging.DEBUG)


class CTDCMeas(threading.Thread):
    def __init__(self):
        logger.info('TDCMeas init')
        threading.Thread.__init__(self)
        signal.signal(signal.SIGINT, thread_exit.sig_handler)
        cmd_tcp_thrd = SocketThread.CMDSocketThread(
            SocketThread.cmd_queue_from_ui)

        data_tcp_thrd = SocketThread.DATASocketThread(
            SocketThread.meas_file_queue_toui)
        thread_exit.thread_pool.append(cmd_tcp_thrd)
        thread_exit.thread_pool.append(data_tcp_thrd)

    def run(self):
        # thread_exit.thread_pool.append(ud_thrd)
        for i in range(len(thread_exit.thread_pool)):
            thread_exit.thread_pool[i].name = thread_exit.thread_pool[i].__class__.__name__
            # thread_exit.thread_pool[i].setDaemon(True)
            thread_exit.thread_pool[i].start()


if __name__ == "__main__":
    from PyQt5.QtWidgets import QApplication
    from PyQt5 import QtCore
    QtCore.QCoreApplication.setAttribute(QtCore.Qt.AA_EnableHighDpiScaling)
    QtCore.QCoreApplication.setAttribute(QtCore.Qt.AA_UseHighDpiPixmaps)
    app = QApplication(sys.argv)
    ex = ui_win.CQtUI(SocketThread.cmd_queue_from_ui,
                      SocketThread.meas_file_queue_toui)
    tdc_app = CTDCMeas()
    tdc_app.start()
    app.exec_()
    thread_exit.sig_handler(1, 1)
