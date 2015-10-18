#!/bin/bash
#while 后面
#  while :
#  while true
#  while [ 1 ]
#  while [ 0 ]

while :
do
	read -p "Input a num:" number
	echo $number >> /tmp/file1;
	if [[ $number == "END" ]]
	then	
		break;
	fi
done
