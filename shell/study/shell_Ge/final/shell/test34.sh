#!/bin/bash
#comment
a=( `awk '{print $1}' user.txt` )
b=( `awk '{print $2}' user.txt` )

for (( i=0; i<${#a[@]}; i++ )) 
do
	if ! id "${a[i]}" &> /dev/null
	then
		useradd "${a[i]}"
		echo "${b[i]}" | passwd "${a[i]}" --stdin &> /dev/null
		echo "${a[i]} create ok";
	else
		echo "${a[i]} exist";
	fi
done
