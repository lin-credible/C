# def format_name(s):
#     return s.upper()[:1] + s.lower()[1:]
# 
# print map(format_name, ['adam', 'LISA', 'barT'])


# def cmp_ignore_case(s1, s2):
#     lS1 = s1.lower()
#     lS2 = s2.lower()
#     if lS1 < lS2:
#         return -1
#     if lS1 > lS2:
#         return 1
#     return 0
# 
# print sorted(['bob', 'about', 'Zoo', 'Credit'], cmp_ignore_case)


# def calc_prod(lst):
#     
#     def xxx(x, y):
#         return x * y
#         
#     def calc_real():
#         return reduce(xxx, lst) 
#     return calc_real
# 
# f = calc_prod([1, 2, 3, 4])
# print f()


# import time
# 
# def performance(f):
#     def fn(*args, **kw):
#         print 'call ', f.__name__, '() in ', time.time()
#         return f(*args, **kw)
#     return fn
# 
# @performance
# def factorial(n):
#     return reduce(lambda x,y: x*y, range(1, n+1))
# 
# print factorial(10)


# import time
# 
# def performance(unit):
#     def perform_unit(f):
#         def wrapper(*args, **kw):
#             t1 = time.time()
#             r = f(*args, **kw)
#             t2 = time.time()
#             t = (t2 - t1) * 1000 if unit =='ms' else (t2 - t1)
#             print 'call %s() in %f %s' % (f.__name__, t, unit)
#             return r
#         return wrapper
#     return perform_unit
#     
# @performance('ms')
# def factorial(n):
#     return reduce(lambda x,y: x*y, range(1, n+1))
# 
# print factorial(10)

# import os
# print os.path.isdir(r'/Users/colintao/Colin/githubSpace/codes-test/python/learning')


# class Person(object):
# 
#     def __str__(self):
#     	return self.name
# 
#     pass
# 
# p1 = Person()
# p1.name = 'Bart'
# 
# p2 = Person()
# p2.name = 'Adam'
# 
# p3 = Person()
# p3.name = 'Lisa'
# 
# L1 = [p1, p2, p3]
# L2 = sorted(L1, key = lambda item: item.name)
# 
# print L2[0].name
# print L2[1].name
# print L2[2].name

class Person(object):
    def __init__(self, name, score):
        self.name = name
        self.__score = score

p = Person('Bob', 59)

print p.name
print p.__score
