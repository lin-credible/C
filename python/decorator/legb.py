#!/usr/bin/env python
# encoding: utf-8

passline = 60

def func(val):
    passline = 90
    if val >= passline:
        print ('pass')
    else:
        print ('failed')
    def in_func():
        print (val)
    in_func()

def Max(val1, val2):
    return max(val1, val2)

func(89)
print Max(89, 100)

