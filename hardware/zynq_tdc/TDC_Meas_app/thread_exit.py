#!/usr/bin/python3
# -*- coding: utf-8 -*-
import sys
import time


global is_exit
is_exit = False

global thread_pool
thread_pool = []


def sig_handler(signum, frame):
    global is_exit
    global thread_pool
    is_exit = True
    while 1:
        alive = False
        for i in range(len(thread_pool)):
            alive = alive or thread_pool[i].is_alive()
            time.sleep(0.1)
        if not alive:
            break
    sys.exit(0)
