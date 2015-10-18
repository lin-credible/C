#!/bin/bash
#comment
warn=5
ip=( 192.168.0.222 192.168.0.222 192.168.0.222 );
for i in "${ip[@]}"
do
	ssh root@$i df -hT > /tmp/file1
	echo "${ip[0]}:" 
	cat /tmp/file1 | tr -s " " | \
	awk -v w=$warn -F "[ %]" \
	'/^\/dev/{if($6>w) print $1 " usage is > " $6 "%"}'
done
