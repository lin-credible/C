#!/bin/bash
#ntp
#level 1
. lib.sh
checkRPM ntp

modifyZone()
{
	clock="/etc/sysconfig/clock";
	zone=$( date +%Z )
	if [[ "$zone" != "CST" ]]
	then
		sed -i '/ZONE/c ZONE="Asia/Shanghai"' $clock;
		cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	fi
}

lev1Config()
{
	cat > /etc/ntp.conf << EOF
	restrict default kod nomodify notrap nopeer noquery
	restrict -6 default kod nomodify notrap nopeer noquery

	restrict 127.0.0.1 
	restrict -6 ::1

	restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap

	server	127.127.1.0	# local clock

	fudge	127.127.1.0 stratum 10	
	driftfile /var/lib/ntp/drift
	keys /etc/ntp/keys
EOF
}

ip1="192.168.0.222"
ip2="192.168.0.223"
lev2Config()
{
	cat > /etc/ntp.conf << EOF
	restrict default kod nomodify notrap nopeer noquery
	restrict -6 default kod nomodify notrap nopeer noquery

	restrict 127.0.0.1 
	restrict -6 ::1

	restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap
	#restrict $ip1

	server	$ip1 prefer

	fudge	127.127.1.0 stratum 10	
	driftfile /var/lib/ntp/drift
	keys /etc/ntp/keys
EOF
}

if (( $1 == 1 ))
then
	lev1Config
	modifyZone
elif (( $1 == 2 ))
then
	lev2Config
	echo $ip1 > /etc/ntp/step-tickers
	modifyZone
else
	modifyZone
	echo "*/10 * * * * { /usr/sbin/ntpdate $ip2 && /sbin/hwclock -w &> /dev/null; }" > /var/spool/cron/$USER
fi

startS ntpd
