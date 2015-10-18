#!/bin/bash
#comment
warn="10M"
crit="11M"
getUN()
{
	un=$( echo $1 | tr -d "0-9" )
}
getVA()
{
	va=$( echo $1 | tr -d "a-zA-Z" )	
}
# --------------------------------------------
getUN $warn
warnUN=$un
getVA $warn
warnVA=$va
# --------------------------------------------
getUN $crit
critUN=$un
getVA $crit
critVA=$va
# --------------------------------------------
cal()
{
	case "$1" in	
		k|K)		v=$2;;
		m|M)		(( v=$2*1024 ));;
		g|G)		(( v=$2*1024*1024 ));;
		*)		echo "error";
				exit 1;;
	esac
}
cal $warnUN $warnVA
warn=$v
cal $critUN $critVA
crit=$v
while :
do
	space=$( df /boot | tail -1 | awk '{print $3}')	
	if (( $space >= $crit )); then
		df -h /boot | mail -s "/boot crit" root
	elif (( $space >= $warn )); then
		df -h /boot | mail -s "/boot warn" root
	else
		echo "/boot is safe"
	fi
	sleep 3
done
