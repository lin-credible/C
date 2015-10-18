#!/bin/bash
ip="192.168.0."
for i in "$ip"{1..254}
do
	(
		wget ftp://"${i}" &> /dev/null	#这样就可以判断是否打开了匿名的FTP服务！
		if (( $? == 0 ))
		then
			echo "$i 已开启匿名FTP服务"
			rm -f index.html*
		fi
	) &	# ()&-->这样可以将其放到后台!
done
wait
exit 0
