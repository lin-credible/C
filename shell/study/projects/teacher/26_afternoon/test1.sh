#!/bin/bash
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#
#Writer: Lin-credible
#Time:2012.7.26 pm
#mail:  Lin-credible@foxmail.com
#function: The initial script of the vsftpd service!
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

start_fun()
{
	echo "starting vsftpd service"
	/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf	
	echo "Done"
}

stop_fun()
{
	echo "stopping vsftpd service"
	a=`ps aux | grep vsftpd | grep -v "grep" | awk '{print $2}'`
	if [ -n "$a" ]
	then 
		kill -9 $a
		#pkill vsftpd
	else
		echo "vsftp is stopped"
	fi
	echo "Done"
}

status_fun()
{
	a=`ps aux | grep vsftpd | grep -v "grep" | awk '{print $2}'`
	if [ -n "$a" ]
	then 
		echo "vsftp is running....(pid $a)..."
	else
		echo "vsftp is stopped"
	fi
}

case "$1" in
start)
	start_fun
;;
stop)
	stop_fun
;;
restart)
	stop_fun
	start_fun
;;
status)
	status_fun
;;
*)
	echo "Usage--> start|stop|restart|status"
;;
esac
