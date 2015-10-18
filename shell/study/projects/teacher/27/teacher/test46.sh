#!/bin/bash
#comment
ip="192.168.0."
for (( i=1; i<=254; i++ ))
do
	(
		arping -c 1 -w 1 "${ip}$i" &> /dev/null
		if (( $? == 0 ))
		then
			arp -n | grep "${ip}$i" | awk '{print $1 "\t" $3}' | sed 's/eth0/no/'
			#从 arp 缓存表中取!不能重新 arping，因为它是重新打开的一个进程!
		fi
	) &	#()& 这样就可以让254个进程并行执行!不然，很慢!
done
wait
exit 0;
