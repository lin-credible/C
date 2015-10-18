#!/bin/bash
#comment
s=( 0 2 3 6 7 )
for (( i=2; i>0; i-- ))
do
	len=${#s[@]}
	(( ra=$RANDOM % $len ))
	arr[x++]=${s[ra]}	
	unset s[$ra]
	s=( ${s[@]} )
done

for (( i=0; i<=1; i++ ))
do
	echo -n ${arr[i]}
done
echo

for (( i=1; i>=0; i-- ))
do
	echo -n ${arr[i]}
done
echo
