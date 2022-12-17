#!/usr/bin/env python

from datetime import datetime
import os
import psutil
import time

def cpu():
    return psutil.cpu_percent()
 
def current_time():
    return datetime.now().strftime\
    ("^c#6CC335^ %A %B %d^c#FF9000^ %H:%M:%S")

def ram():
    return psutil.virtual_memory()[3]/1000000000

while True:
    os.system\
    ('xsetroot -name "\
    ^c#26BC91^{}%^c#63AAFF^ {} GB{} "'\
    .format(cpu(), ram(), current_time()))
    
    time.sleep(1)
