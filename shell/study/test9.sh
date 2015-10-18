#!/bin/bash
#comment
#for i in tom pwd_123 20 10000 15200860264
#do
#	r1[x++]=$i;
#	# x初始值为0!	
#	#  r1[x]=$i; or r1[$x]=$i;
#	#+ let x++;
#	# Notice:x不能替换成 i 的值是tom, pwd_123……
#done
#
#echo ${r1[@]}
#
#arr1=(tom jerry mike lee)
#i=0;
#while (( i < ${#arr1[@]} ))
#do 
#	echo ${arr1[i]}
#	let i++
#done
#
for i in tome aaa bbb ccc
do
	r1[x++]=$i;
	echo ${r1[--x]}
	echo $x
	echo -------------
done

for i in tome aaa bbb ccc
do
	r1[x]=$i;
	echo ============
	echo ${r1[x]}
	let x++;
	echo "x=" $x;
	echo -------------
done
echo +++++++++++++++++++++++++++++
for i in tome aaa bbb ccc
do
	r1[x++]=$i;
	echo ${r1[ (( x-1 )) ]}
	echo $x
	echo -------------
done


