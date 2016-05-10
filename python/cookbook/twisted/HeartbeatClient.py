#!/usr/bin/env python
# encoding: utf-8

"""
Heartbeat 客户端, 周期性发送UDP包
"""

import socket, time

SERVER_IP = '192.168.0.4'
SERVER_PORT = 44444
BEAT_PERIOD = 5
print 'Sending heartbeat to IP %s, port %d' % (SERVER_IP, SERVER_PORT)
print 'press Ctrl-C to stop'
while True:
    hbSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    hbSocket.sendto('PyHB', (SERVER_IP, SERVER_PORT))
    if __debug__:
        print 'Time: %s' % time.ctime( )
    time.sleep(BEAT_PERIOD)
