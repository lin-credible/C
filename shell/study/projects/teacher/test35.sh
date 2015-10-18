#!/bin/bash
#comment
s="02367"
for ((i=2; i>0; i--))
do
	len=${#s}
	(( ra=$RANDOM % $len ))
	arr[x++]=${s:$ra:1}
	
	a=${s:0:$ra}	
	b=${s:$ra+1}	
	s="$a$b"
done

for i in "${arr[@]}"
do
	echo -n $i
done
echo

for ((i=1; i>=0; i--))
do
	echo -n "${arr[i]}"
done
echo
