#!/bin/bash
#ntp
. lib.sh
check_rpm ntp

level_config_1()
{
#level 1
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
level_config_2()
{
#level2
	cat > /etc/ntp.conf << EOF
	restrict default kod nomodify notrap nopeer noquery
	restrict -6 default kod nomodify notrap nopeer noquery
	
	restrict 127.0.0.1 
	restrict -6 ::1
	restrict 192.168.0.0 mask 255.255.255.0 nomodify notrap
	#restrict $ip1
	server	$ip1 prefer	# local clock

	fudge	127.127.1.0 stratum 10	
	driftfile /var/lib/ntp/drift
	keys /etc/ntp/keys
EOF
}

modifyZone()
{
	clock="/etc/sysconfig/clock";
	zone=$( date +%Z )
	if [[ "$zone" != "CST" ]]
	then
		sed -i '/ZONE/c ZONE="Asia/Shanghai"' $clock;
		cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &>/dev/null
	fi
}

if (( $1 == 1 ))
then
# 一级服务器
	level_config_1
	modifyZone
elif (( $1 == 2 ))
then
# 二级服务器
	level_config_2
	echo $ip1 > /etc/ntp/step-tickers
	modifyZone
else
# 客户端
	modifyZone
	echo "*/10 * * * * {/usr/sbin/ntpdate $ip2 && /sbin/hwclock -w &> /dev/null}" >> /var/spool/cron/$USER
fi

start_server ntpd
