#!/bin/bash
#comment
#打印整个网断的 ip mac

my_ip=`ifconfig eth0 | egrep -A 1 "^\w" | egrep "inet addr" |awk -F"[: ]" '{print $13}'`
net=`ifconfig eth0 | egrep -A 1 "^\w" | egrep "inet addr" |awk -F"[: ]" '{print $13}'| awk -F. 'BEGIN{OFS="."}{print $1,$2,$3"."}'`
for (( i=1; i<20; i++ ))
do
	other=${net}$i
	if ping -c 2 $other &> /dev/null
	then
		a=`arping -c 2 $other | grep "reply" | awk '{print $4": "$5}'` &> /dev/null
		echo "$a"  >> /tmp/file_mac	
	else
		continue 
	fi
done
echo "=====Net:${net}0~255========="
cat /tmp/file_mac| sort -r| uniq | grep -v "^$" > /tmp/file_mac
cat /tmp/file_mac
