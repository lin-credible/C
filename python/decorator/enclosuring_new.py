#!/usr/bin/env python
# encoding: utf-8

#def func_150(val):
#    passline = 90
#    if val >= passline:
#        print ('%d pass' %val)
#    else:
#        print ('failed')
#
#def func_100(val):
#    passline = 60
#    if val >= passline:
#        print ('%d pass' %val)
#    else:
#        print ('failed')
#
#func_150(89)
#func_100(89)

def set_passline(passline):
    def cmp(val):
        if val >= passline:
            print ('Pass')
        else:
            print ('Failed')
    return cmp

f_100 = set_passline(60)
f_150 = set_passline(90)
#print(type(f_100))
#print(f_100.__closure__)
f_100(89)
f_150(89)

