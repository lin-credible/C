#!/bin/bash
# 
#
a=( 0 2 3 6 7 )
for (( b=1; b<3; b++ ))
do
	len=${#a[@]}
	num=`expr $RANDOM % $len`
	echo -ne ${a[$num]}
	unset a[$num]
	a=( ${a[@]} )
done
echo 
