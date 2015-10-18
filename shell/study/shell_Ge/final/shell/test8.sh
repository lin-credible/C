#!/bin/bash
#comment
#if [ ! -d "/tmp/{sda1,sda3}" ]
#then
#	( mkdir /tmp/{sda1,sda3} > /dev/null 2>&1 )
#fi
#
#if ls $1 &> /dev/null
#then
#	chmod 600 $1;
#else
#	echo "the file $1 is not exist";
#fi
#
#read -p "how old are your: " age
#if (( age <= 0 || age >= 120 ))
#then
#	echo "error"
#	exit 10;		
#fi
#date


pgrep "vsftpd" &> /dev/null
if (( $? == 0 )) # [ $? -eq 0 ]
then
	echo "ftp is running...";
elif [ -x "/etc/init.d/vsftpd" ]
then
	service vsftpd start;
else
	echo "ftp is not install!";
fi
