#!/bin/bash
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#要做 dhcp 服务，必须保证自己的IP是静态的!
#服务器IP和分发的IP需要在同一个网段!
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
. lib.sh 
check_rpm dhcp;

cat <<EOF > /etc/dhcpd.conf
ddns-update-style interim;
default-lease-time 21600;
max-lease-time 43200;

subnet 192.168.0.0 netmask 255.255.255.0 {
# --- default gateway
	option routers			192.168.0.1;
	option subnet-mask		255.255.255.0;
	option domain-name-servers	192.168.0.1;
	range dynamic-bootp 192.168.0.108 192.168.0.154;
	# we want the nameserver to appear at a fixed address
	# next-server以后做无人职守安装的时候，需要用到！
	host manager {
		next-server marvin.redhat.com;
		hardware ethernet 12:34:56:78:AB:CD;
		fixed-address 192.168.0.25;
	}
}
EOF
if="eth0"  #若这个文件有问题，dhcpd 服务启动不了！
configFile="/etc/sysconfig/dhcpd"
sed -i "/DHCP/s/=.*/=\"$if\"/" $configFile
#-======>sed  里面有变量替换，需要使用双引号！
start_server dhcpd
exit 0
