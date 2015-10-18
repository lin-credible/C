#!/bin/bash
#comment
#葛老师的习惯是使用函数！这个真好！
#现在只是读脚本，轮到自己能很轻松地写出这些很优秀的脚本出来，我知道还需要大量的exersices!
log="/tmp/alert.txt"
hdWarn="10%"
memWarn="11%"
cpuWarn="12%"
getVA()
{
	va=$( echo "$1" | sed 's/[^0-9]//g' ) #使用sed或tr,将非数字的地方去掉！	
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
# ===========其实我想知道，上面这一段代码的必要性，直接将三个变量赋值为 10，11，12不得了！
hdMonitor()
{
	hd=$( df | grep "/$" | awk '{print $5}' | tr -d "%" ) 
	# 找出根分区的磁盘使用情况！	
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
