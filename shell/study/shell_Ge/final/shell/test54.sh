#!/bin/bash
#comment
flag=0
while :
do
	if (( flag == 0 ))
	then
	  grep "Failed" /var/log/secure | awk '{print $11}' > /tmp/file1
	  mark="$RANDOM$RANDOM"
	  echo "$mark" >> /var/log/secure
	  flag=1
	else
	  sed -n '/'$mark'/,$p' /var/log/secure | grep "Failed" | awk '{print $11}' > /tmp/file1
	fi

	mark="$RANDOM$RANDOM"
	echo "$mark" >> /var/log/secure
	cat /tmp/file1 | sort | uniq -c | awk '$1>5{print $2}' > /tmp/file2
	while read ip
	do
		iptables -I INPUT -s "$ip" -j DROP
	done < /tmp/file2

	sleep 30

	while read ip
	do
		iptables -D INPUT -s "$ip" -j DROP
	done < /tmp/file2

	sleep 30
done
