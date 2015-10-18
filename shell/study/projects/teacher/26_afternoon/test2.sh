#!/bin/bash
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#
#Writer:Lin-credible
#Time: 2012.7.26 
#Mail: Lin-credible@foxmail.com
#
#Function:monitoring the use of the boot apartment!
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

warn1=524288000
warn2=838860800
value=`df -k | grep "/boot" | awk '{print $3}'`
if [ $value -ge $warn1 ]
then
	if [$value -ge $warn2 ]
	then
		echo "Your /boot is very dangerous..."
	else
		echo "Your /boot is dangerous..."
	fi
else
	echo "Your /boot is OK! used: ${value} B"
fi
