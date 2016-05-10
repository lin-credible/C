#!/usr/bin/env python
# encoding: utf-8

"""
多线程 heartbeat 服务端
"""

import socket, threading, time
UDP_PORT = 44444
CHECK_PERIOD = 20
CHECK_TIMEOUT = 15

class Heartbeats(dict):
    """ 用线程管理共享的heartbeats字典 """
    def __init__(self):
        super(Heartbeats, self).__init__()
        self._lock = threading.Lock()
    def __setitem__(self, key, value):
        """ 为某客户端创建或更新字典中的条目 """
        self._lock.acquire()
        try:
            super(Heartbeats, self).__setitem__(key, value)
        finally:
            self._lock.release()
    def getSilent(self):
        """ 返回沉默期长于 CHECK_TIMEOUT 的客户端的列表 """
        limit = time.time() - CHECK_TIMEOUT
        self._lock.acquire()
        try:
            silent = [ip for (ip, ipTime) in self.items() if ipTime < limit]
        finally:
            self._lock.release()
        return silent
class Receiver(threading.Thread):
    """ 接收UDP包并将其记录在heartbeats 字典中"""
    def __init__(self, goOnEvent, heartbeats):
        super(Receiver, self).__init__()
        self.goOnEvent = goOnEvent
        self.heartbeats = heartbeats
        self.recSocket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        self.recSocket.settimeout(CHECK_TIMEOUT)
        self.recSocket.bind(('192.168.0.4', UDP_PORT))
    def run(self):
        while self.goOnEvent.isSet():
            try:
                data, addr = self.recSocket.recvfrom(5)
                if data == 'PyHB':
                    self.heartbeats[addr[0]] = time.time()
            except socket.timeout:
                pass
def main(num_receivers=3):
    receiverEvent = threading.Event()
    receiverEvent.set()
    heartbeats = Heartbeats()
    receivers = []
    for i in range(num_receivers):
        receiver = Receiver(goOnEvent=receiverEvent, heartbeats=heartbeats)
        receiver.start()
        receivers.append(receiver)
    print 'Threaded heartbeat server listening on port %d' % UDP_PORT
    print 'press Ctrl-C to stop'
    try:
        while True:
            silent = heartbeats.getSilent()
            print 'Silent clients: %s' % silent
            time.sleep(CHECK_PERIOD)
    except KeyboardInterrupt:
        print 'Exiting, please wait...'
        receiverEvent.clear()
        for receiver in receivers:
            receiver.join()
        print 'Finished.'
if __name__=='__main__':
    main()
