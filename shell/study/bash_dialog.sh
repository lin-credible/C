#!/bin/bash
#comment
configFile1="/etc/sysconfig/network-scripts/ifcfg-eth0"
configFile2="/etc/resolv.conf"
dialog --title "network set" --form "ip nm gw ns" 15 50 4 \
"ip:" 1 1 "" 1 5 20 0 \
"nm:" 2 1 "" 2 5 20 0 \
"gw:" 3 1 "" 3 5 20 0 \
"ns:" 4 1 "" 4 5 20 0 2>/tmp/file5
#var1=( `cat /tmp/file5 | tr "\n" " "` )
var1=( `cat /tmp/file5 | awk 'BEGIN {FS="\n";RS=" ";ORS=""}{x=1;while(x<NF){print $x "\t";x++}print $NF "\n"}'` )
#[ -n "${var1[0]}" ] && sed -i "/IPADDR/s/=.*/=${var1[0]}/" $configFile1
#当ip处不为零的时候，再替换!
#[ -n "${var1[1]}" ] && sed -i "/NETMASK/s/=.*/=${var1[1]}/" $configFile1
#[ -n "${var1[2]}" ] && sed -i "/GATEWAY/s/=.*/=${var1[2]}/" $configFile1
IFS=" "
echo ${var1[0]}
echo ${var1[1]}
echo ${var1[2]}
echo ${var1[3]}
m()
{
#	[ -n "$1" ] && sed -i "/$2/s/=.*/=$1/" $configFile1
	[[ "$1" != "" ]] && sed -i "/$2/s/=.*/=$1/" $configFile1
}
m ${var1[0]} "IPADDR"
m ${var1[1]} "NETMASK"
m ${var1[2]} "GATEWAY"

[ -n "${var1[3]}" ] && sed -i "/^name/c nameserver ${var1[3]}" $configFile2
