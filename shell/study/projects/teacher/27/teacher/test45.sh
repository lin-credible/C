#!/bin/bash
#comment
#开机就执行
#在/etc/rc.local最后加入如下行:
#cd /root; ./test45.sh &
while : #死循环执行
do
	wget http://localhost/test.html &> /dev/null
	if (( $? != 0 ))
	then
		service httpd restart &> /dev/null
	else
		content=`cat test.html`
		if [ -z "$content" ]
		then
			service httpd restart &> /dev/null
		fi
	fi
	rm -f test.html*;
	sleep 2;
done
