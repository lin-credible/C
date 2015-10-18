#!/bin/bash
#comment
#x=0;
#for i in tom Pwd_123 20 3000 13112345678
#do
#	r1[x]=$i;
#	echo ${r1[x]}
#	let x++;
#	#r1[x]=$i;
#	#let x++;
#done
#
#echo ${r1[@]}
#arr1=(tom jerry mike lee);
#i=0;
#while (( i < ${#arr1[@]} ))
#do
#	echo ${arr1[i]}	
#	let i++;
#done

for i in tom Pwd_123 20 3000
do
	r1[x++]=$i;
	echo ${r1[ ((x-1)) ]}
done

echo $x












