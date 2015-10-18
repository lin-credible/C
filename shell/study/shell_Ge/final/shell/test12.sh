#!/bin/bash
#comment
i=1;
while (( i <=20 ))
do
	if (( i == 8 || i == 18 ))
	then
		(( i++ ))
		continue;
	fi
	userdel -r user$i
	let i++;
done


