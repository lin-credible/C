#!/usr/bin/env python
# encoding: utf-8

import socket

def get_remote_machine_info():
    remote_host = 'www.easyops.cn'
    try:
        print "IP address of %s is: %s" %(remote_host,socket.gethostbyname(remote_host))
    except socket.error, err_msg:
        print "%s: %s" %(remote_host, err_msg)

if __name__ == '__main__':
    get_remote_machine_info()

