#!/bin/bash
ip="192.168.0."
for i in "$ip"{1..254}
do
	(
		wget ftp://"${i}" &> /dev/null
		if (( $? == 0 ))
		then
			echo "$i 已开启匿名FTP服务"
			rm -f index.html*
		fi
	) &
done
wait
exit 0
