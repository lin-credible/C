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
		fi
	) &
done
wait
exit 0;
