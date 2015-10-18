#!/bin/bash
# int-or-string.sh 整形还是字符串?

a=2334		# 整形
let "a += 1"
echo "a = $a " 	
# a =  2335
echo -------------------------

b=${a/23/BB}	# 将 23替换成 BB
		# 这将把变量b从整形变成字符串
echo "b = $b"
# b = BB35

let "b += 1"	# BB35 + 1 =
echo "b = $b"	
# b = 1
echo --------------------------

c=BB34
echo "c = $c"	
# c = BB34
d=${c/BB/23}	# 将“BB”替换成"23".
		# 这使得变量$d变为一个整形
echo "d = $d"	
# d = 2334
let "d += 1"	# 2334 + 1 =
echo "d = $d"	
# d= 2335
echo ------------------------
# null 变量会如何？
e=""
echo "e = $e"	
let "e += 1"
echo "e = $e"
echo --------------------------

echo "f = $f"
let "f += 1"
echo "f = $f"
echo -----------------------

exit 0
