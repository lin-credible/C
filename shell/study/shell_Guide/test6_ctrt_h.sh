#!/bin/bash
# Embedding Ctrl-H in a string.

a="^H^H"	# 两个 Ctrl-H's (backspaces).
echo "abcdef"	# abcdef
echo -n "abcdef$a "	# abcd f
#  Space at end  ^	      ^ 两次退格
echo -n "abcdef$a"	# abcdef
# 结尾没有空格	没有 backspace的效果了（why?)
echo;
# --------------------没有效果!
# 打印的结果是：
#    abcdef
#+   abcdef^H^H abcdef^H^H
#    ???
