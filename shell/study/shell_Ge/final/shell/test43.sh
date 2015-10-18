#!/bin/bash
#comment
log="/tmp/alert.txt"
hdWarn="10%"
memWarn="11%"
cpuWarn="12%"
getVA()
{
	va=$( echo "$1" | sed 's/[^0-9]//g' ) #使用sed或tr	
	return 0;
}
# --------------------------------------------
getVA $hdWarn
hdWarn=$va
# --------------------------------------------
getVA $memWarn
memWarn=$va
# --------------------------------------------
getVA $cpuWarn
cpuWarn=$va
# --------------------------------------------
hdMonitor()
{
	hd=$( df | grep "/$" | awk '{print $5}' | tr -d "%" )	
	#echo $hd
	if (( $hd > $hdWarn ))
	then
		echo "the hd / use ${hd}% > ${hdWarn}%" >> $log
		hdInfo="warn: the hd / use ${hd}% > ${hdWarn}%"
		return 1;
	else
		return 0;
	fi
}
! hdMonitor && echo "$hdInfo"
memMonitor()
{
	arr=( `free | grep "Mem"` )	
	use=$( echo "scale=2; ${arr[2]}/${arr[1]}" | bc )
	mem=$( echo $use | cut -d "." -f2 )
	#echo $mem
	if (( $mem > $memWarn ))
	then
		echo "the mem use ${mem}% > ${memWarn}%" >> $log
		memInfo="warn: the mem use ${mem}% > ${memWarn}%"
		return 1;
	else
		return 0;
	fi
}
! memMonitor && echo "$memInfo"
cpuMonitor()
{
	cpu=$( top -b -n 1 | grep "Cpu" | awk '{print $5}' | awk -F. '{print $1}' )
	(( cpu=100-$cpu ))
	#echo $cpu
	if (( $cpu > $cpuWarn ))
	then
		echo "the cpu use ${cpu}% > ${cpuWarn}%" >> $log
		cpuInfo="warn: the cpu use ${cpu}% > ${cpuWarn}%"
		return 1;
	else
		return 0;
	fi
}
! cpuMonitor && echo "$cpuInfo"
[ -f $log ] && cat $log | mail -s "alert message" root && rm -f $log
