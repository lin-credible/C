#!/bin/bash
#comment
#开机就执行
#在/etc/rc.local最后加入如下行:
#cd /root; ./test45.sh & --->注意，这儿如果没有这个后台运行的话，系统就会出问题了!
#+因为系统启动的时候会读取 rc.local,而这里面有死循环，永远出不来了!
#+貌似上面的方法，也是一种简单的黑客的做法噢～加个死循环的代码，就OK了!
while : #死循环
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
	rm -f test.html*;  # 如果apache运行成功的话,它会有html1,html2...等很多!
	sleep 2;
done
