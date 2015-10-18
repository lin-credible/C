#!/bin/bash
#comment
configFile1="/etc/sysconfig/network-scripts/ifcfg-eth0"
configFile2="/etc/resolv.conf"
dialog --title "network set" --form "ip nm gw ns" 15 50 4 \
"ip:" 1 1 "" 1 5 20 0 \
"nm:" 2 1 "" 2 5 20 0 \
"gw:" 3 1 "" 3 5 20 0 \
"ns:" 4 1 "" 4 5 20 0 2> file1

var1=( `cat file1 | sed "s/^/#/"` )

for i in "${var1[@]}"
do
	var1[x++]=`echo $i | sed "s/#//"`;
done

m()
{
	sed -i "/$2/s/=.*/=$1/" $configFile1
}

[ -n "${var1[0]}" ] && m ${var1[0]} "IPADDR"
[ -n "${var1[1]}" ] && m ${var1[1]} "NETMASK"
[ -n "${var1[2]}" ] && m ${var1[2]} "GATEWAY"
[ -n "${var1[3]}" ] && sed -i "/^name/c nameserver ${var1[3]}" $configFile2
