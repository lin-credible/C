#!/bin/bash

s="02367"
for(( i=2; i>0; i--   ))
do
	len=${#s}
	(( ra=$RANDOM % $len ))
	arr[x++]=${s:$ra:1} #避免将之前生成的覆盖
#----------------------------------
#必须重新生成去掉上次取到过的数字的新的数字串 s
	a=${s:0:$ra} #取出$ra 前面的数字
	b=${s:$ra+1} #取出$ra 后面的所有数字
	s="$a$b"
done
#echo "${arr[0]}${arr[1]}"
#echo "${arr[1]}${arr[0]}"

#--------------------这种方法倒序打印不方便!
for i in "${arr[@]}"
do
	echo -n $i
done
echo 

#------------------------两个结合起来就行了!-
for (( i=1; i>=0; i-- ))
do
	echo -n "${arr[i]}"
done
echo
