#!/bin/bash
#comment
while :
do
	flag=0;
	# -----------------------------------------------------------
	# 如果主网关10.0.0.1是通的, 则切回主网关	
	while ping -c 1 -i 1 -W 1 10.0.0.1 &> /dev/null
	do
		route -n | grep "10.0.0.1" &> /dev/null
		if (( $? != 0 ))
		then
			route del default
			route add default gw 10.0.0.1
			echo "`date '+%F %T'` 20.0.0.1 -> 10.0.0.1" >> /var/log/routeSwitch.log
		fi
		flag=1
		sleep 2
	done
	# -----------------------------------------------------------
	# 如果主网关10.0.0.1不通, 则切到辅网关20.0.0.1
	until ping -c 1 -i 1 -W 1 10.0.0.1 &> /dev/null
	do
		# 如果辅网关20.0.0.1也不通, 则记录二者均不通到日志
		ping -c 1 -i 1 -W 1 20.0.0.1 &> /dev/null
		if (( $? != 0 ))
		then
			break
		fi

		route -n | grep "20.0.0.1" &> /dev/null
		if (( $? != 0 ))
		then
			route del default
			route add default gw 20.0.0.1			
			echo "`date '+%F %T'` 10.0.0.1 -> 20.0.0.1" >> /var/log/routeSwitch.log
		fi
		flag=1
		sleep 2
	done

	if (( flag == 0 ))
	then
		echo "`date '+%F %T'` 10.0.0.1 and 20.0.0.1 all down" >> /var/log/routeSwitch.log
	fi

done
