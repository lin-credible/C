#!/bin/bash
#comment
start()
{
	echo 'starting vsftpd...';
	/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf && echo 'Done';
}
stop()
{
	ps aux | grep "vsftpd" | grep -v "grep" &> /dev/null
	(( $? == 0 )) && killall vsftpd && echo 'Done'
}
status()
{
	ps aux | grep "vsftpd" | grep -v "grep" &> /dev/null
	if (( $? == 0 ))
	then
		echo "vsftpd is running."
	else
		echo "vsftpd is stopped."
	fi
}
case "$1" in
start)		start;;
stop)		stop;;
restart)	stop && start;;
status)		status;;
*)		echo "usage: $0 start|stop|restart|status";;
esac
exit 0
