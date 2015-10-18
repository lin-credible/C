#!/bin/bash
#comment
num=$( wc -l user.txt | awk '{print $1}' ) 
for ((i=1; i<=num; i++))
do
	un=$( awk -v a=$i 'NR==a{print $1}' user.txt )
	pa=$( awk -v b=$i 'NR==b{print $2}' user.txt )
	if ! id "${un}" &> /dev/null
	then
		useradd "${un}"
		echo "${pa}" | passwd "${un}" --stdin &> /dev/null
		echo "${un} create ok!";
	fi

done
