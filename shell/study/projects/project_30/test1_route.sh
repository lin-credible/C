#!/bin/bash
trap 'echo Bye;exit 1;' 1 2 9 15	#接受信号?
while :
	do
		while ping -c 1 10.1.1.1 &> /dev/null
		do
			sleep 2 	#休息两分钟
		done
		ping -c 1 20.1.1.1 &>/dev/null
		if [ $? -ne 0 ]
		then
			echo "路由全部中断"
			continue 	#退出后重新执行脚本
		fi
		route del default
		route add default gw 20.1.1.1
		echo "默认路由已经切换到20.1.1.1"
		until ping -c 1 10.1.1.1 &>/dev/null
		do
			sleep 2
		done
		route del default
		route add default gw 10.1.1.1
		echo "默认路由已经切换到10.1.1.1"
	done
