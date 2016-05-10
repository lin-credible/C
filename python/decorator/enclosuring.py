#!/usr/bin/env python
# encoding: utf-8

passline = 60#100
def func(val):
    passline = 90
    print ('%x' %id(val))
    if val >= passline:
        print ('pass')
    else:
        print ('failed')
    def in_func():#(val,)
        print (val)
    in_func()
    return in_func

f = func(89)
f() #in_func
print (f.__closure__)

