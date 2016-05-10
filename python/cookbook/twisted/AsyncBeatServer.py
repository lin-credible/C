#!/usr/bin/env python
# encoding: utf-8

import time
from twisted.application import internet, service
from twisted.internet import protocol
from twisted.python import log
UDP_PORT = 44444
CHECK_PERIOD = 20
CHECK_TIMEOUT = 15
class Receiver(protocol.DatagramProtocol):
    """ 接收UDP包并将其记录在 "客户端" 的字典中 """
    def datagramReceived(self, data, (ip, port)):
        if data == 'PyHB':
            self.callback(ip)
class DetectorService(internet.TimerService):
    """ 探测长时间没有心跳的客户端 """
    def __init__(self):
        internet.TimerService.__init__(self, CHECK_PERIOD, self.detect)
        self.beats = {}
    def update(self, ip):
        self.beats[ip] = time.time()
    def detect(self):
        """ 记录沉默期长于 CHECK_TIMEOUT 的客户端列表 """
        limit = time.time() - CHECK_TIMEOUT
        silent = [ip for (ip, ipTime) in self.beats.items() if ipTime < limit]
        log.msg('Silent clients: %s' % silent)
application = service.Application('Heartbeat')
# define and link the silent clients' detector service
# 定义并连接 detector 服务
detectorSvc = DetectorService()
detectorSvc.setServiceParent(application)
# create an instance of the Receiver protocol, and give it the callback
# 创建一个Receiver协议的实例，给它设置回调函数
receiver = Receiver()
receiver.callback = detectorSvc.update
# 定义并连接UDP服务, 传入receiver
udpServer = internet.UDPServer(UDP_PORT, receiver)
udpServer.setServiceParent(application)
# 在 twisted 运行时所有服务自动开始
log.msg('Asynchronous heartbeat server listening on port %d\n' 'press Ctrl-C to stop\n' % UDP_PORT)
