#!/bin/bash
#comment
configFile1="/etc/sysconfig/network-scripts/ifcfg-eth0"
configFile2="/etc/resolv.conf"
dialog --title "network set" --form "ip nm gw ns" 15 50 4 \
"ip:" 1 1 "" 1 5 20 0 \
"nm:" 2 1 "" 2 5 20 0 \
"gw:" 3 1 "" 3 5 20 0 \
"ns:" 4 1 "" 4 5 20 0 2> file1

ip=`sed -n '1p' file1` 
nm=`sed -n '2p' file1` 
gw=`sed -n '3p' file1` 
ns=`sed -n '4p' file1` 

m()
{
	sed -i "/$1/s/=.*/=$2/" $configFile1 
} 

[[ -n $ip ]] && m "IPADDR" $ip
[[ -n $nm ]] && m "NETMASK" $nm
[[ -n $gw ]] && m "GATEWAY" $gw

[ -n "$ns" ] && sed -i "/^name/c nameserver $ns" $configFile2
