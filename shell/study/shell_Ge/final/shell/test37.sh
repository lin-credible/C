#!/bin/bash
#comment
ipMask()
{
	if ! ifconfig $1 | grep "inet addr" &> /dev/null
	then
		echo "$1 no ip/netmask"
	else
		echo -e "${1}:\t\t" `ifconfig $1 | grep "inet addr" | tr ":" " " | tr -s " " | cut -d " " -f$2,$3 | tr " " "/"`
	fi
}
for i in $( ifconfig -a | grep "^\w" | awk '{print $1}' )
do
	if [[ "${i}" == "lo" ]]; then
		ipMask "$i" "4" "6"
	else
		ipMask "$i" "4" "8"
	fi
done
