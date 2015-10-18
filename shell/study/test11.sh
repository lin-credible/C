pgrep "vsftpd" &> /dev/null
if (( $? == 0 )) # [ $? -eq 0 ] 
then
	echo "Ftp is running...";
elif [ -x "/etc/rc.d/init.d/vsftpd" ]
then
	service vsftpd start;
else	
	echo "Ftp is not installed!"
fi
