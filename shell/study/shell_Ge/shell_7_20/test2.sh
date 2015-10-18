#!/bin/bash
#dhcp server
. lib.sh
checkRPM dhcp;

echo "dhcp server config static ip!";
echo "ip and subnet ip is same network";

cat << EOF > /etc/dhcpd.conf
ddns-update-style none;
default-lease-time 21600;
max-lease-time 43200;

subnet 192.168.0.0 netmask 255.255.255.0 {
	option routers			192.168.0.1;
	option subnet-mask		255.255.255.0;
	option domain-name-servers	192.168.0.1, 172.16.1.1;
	range dynamic-bootp 192.168.0.100 192.168.0.150;
	host manager1 {
		hardware ethernet 00:34:56:78:AB:CD;
		fixed-address 192.168.0.20;
	}
}
EOF

if="eth0"
configFile="/etc/sysconfig/dhcpd"
sed -i "/DHCP/s/=.*/=\"$if\"/" $configFile

startS dhcpd
