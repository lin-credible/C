#!/bin/bash
#comment
#思路二

#1. 需要函数!a, 判断 20.1.1.1是否能通的函数! b,判断 10.1.1.1是否能通的函数!这个可以用一个函数实现，通过传参即可！
#2. 启用网关 10.1.1.1的时候，用死循环，如果不通了，则判断是否 20.1.1.1能用，若能，则替换!然后继续死循环判断 10.1.1.1的连通性！
#2+ 若通了，则替换出来！

#3:这个脚本其实写得很盲目！因为貌似还没怎么弄懂这个网络环境!
#3+ a:网关有两个网卡(?),分别连接 10.1.1.1, 20.1.1.1!客户端怎么处理?不要管么?
#3+ b: 我们的这个脚本是运行在网关上的!


ug1="10.1.1.1"
ug2="20.1.1.1"
gateway=`cat /etc/sysconfig/network-scripts/ifcfg-eth0 | grep "GATEWAY" | awk -F "=" '{print $2}'`
date1=`date +%F`
time1=`date +%T`	#这个时间不能写在外面!应该在写日志的时候再获取!
ug_ping()
{
	arping -c 1 -w 1 "$1" &>/dev/null
	if (( $? == 0 ))
	then
		if (( $gateway != $1 ))
		then
			sed -i '/^GATEWAY/s/^.*$/GATEWAY=$1/' /etc/sysconfig/network-scripts/ifcfg-eth0	
			echo "${date} ${time1} ${gateway}----> $1" >> /tmp/log_gateway.txt
		fi
		exit 0;	
	else
		exit 1;
	fi
}

while :
do
	ug_ping $ug1
	if (( $? == 1 ))
	then
		ug_ping $ug2	
		sleep 1
		continue
	fi
done
