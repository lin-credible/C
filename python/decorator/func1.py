#!/usr/bin/env python
# encoding: utf-8

def my_sum(*arg):
    #if len(arg) == 0:
    #    return 0
    #for val in arg:
    #    if not isinstance(val, int):
    #        return 0
    return sum(arg)
def my_average(*arg):
    #if len(arg) == 0:
    #    return 0
    #for val in arg:
    #    if not isinstance(val, int):
    #        return 0
    return sum(arg)/len(arg)

def dec(func):
    def in_dec(*arg):
        print ('In dec arg=', arg)
        if len(arg) == 0:
            return 0
        for val in arg:
            if not isinstance(val, int):
                return 0
        return func(*arg)
    return in_dec

my_sum = dec(my_sum)

print (my_sum(1,2,3,4,5))
print (my_sum(1,2,3,5, '6'))
#print (my_average(1, 2, 3, 4))
#print (my_average())
