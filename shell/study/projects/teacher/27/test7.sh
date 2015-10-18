#!/bin/bash
#comment
#打印网段允许匿名用户访问的 ftp 服务器

my_ip=`ifconfig eth0 | egrep -A 1 "^\w" | egrep "inet addr" |awk -F"[: ]" '{print $13}'`
net=`ifconfig eth0 | egrep -A 1 "^\w" | egrep "inet addr" |awk -F"[: ]" '{print $13}'| awk -F. 'BEGIN{OFS="."}{print $1,$2,$3"."}'`
for (( i=0; i<12; i++ ))
do
	other=${net}$i
	if ping -c 2 $other &> /dev/null
	then
	#怎么判断是否登录拒绝?怎么在expect中进行流程控制？
		#. ftp2.exp $other &>/dev/null
		#. ftp1.exp $other &>/dev/null
		a=`arping -c 2 $other | grep "reply" | awk '{print "FTP: "$4": "$5}'` &> /dev/null
		echo "$a"  >> /tmp/file_mac	
	else
		continue 2	
	fi
done
echo "=====FTP:${net}0~255========="
cat /tmp/file_mac | grep -v "^$"
rm -rf /tmp/file_mac
