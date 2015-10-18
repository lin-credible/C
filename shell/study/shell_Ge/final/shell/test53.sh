#!/bin/bash
#只对C类网段地址
#./test53.sh 192.168.1.0
checkNetAddress()
{
	ip1=$( echo "$1" | awk -F. '$1>=1 && $1<=254{print $1}' )	
	ip2=$( echo "$1" | awk -F. '$2>=0 && $2<=255{print $2}' )	
	ip3=$( echo "$1" | awk -F. '$3>=0 && $3<=255{print $3}' )	
	ip4=$( echo "$1" | awk -F. '$4==0{print $4}' )	

	if [ -z "$ip1" -o -z "$ip2" -o -z "$ip3" -o -z "$ip4" ]
	then
		echo "net address error."
		exit 1
	fi
}
checkNetAddress $1

for ((i=1; i<=254; i++))
do
	(
		ping -c 1 -i 1 -W 1 $ip1.$ip2.$ip3.$i &> /dev/null
		if (( $? == 0 ))
		then
		  nmap $ip1.$ip2.$ip3.$i | sed '1,4d' | sed '$d' | sed '$d' >> /tmp/portScan.log
		else
		  echo "$ip1.$ip2.$ip3.$i unreachable"
		fi
	) &
done
wait
exit 0
