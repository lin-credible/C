#!/bin/bash
#
i=1;
while (( i <= 20 ))
do
	#if [ i -eq "1?8" ] # 不支持正则表达式!ai~~~
	if (( i == 8 || i == 18 ))
	then	
		(( i++ ))
		continue;
	fi
	userdel -r user$i
	let i++;
done
