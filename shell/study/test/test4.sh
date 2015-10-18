#for i in `seq 6`
#do
#	if (( i % 2 == 0 ))
#	then
#	#	break;跳出整个 for 的循环体!
#		continue; # 跳出本次循环,继续从头执行!
#	fi
#	echo "$i"
#done 
#echo "Over $i"

#------------------------类C 的写法！-----------------
for (( i=0; i<=3; i++ ))
do
	for (( j=0; j<=4; j++ ))
	do
		#(( $j == 3 )) && break;  NOTICE:如果有 break 2, 那么会跳出最外层的循环!
		(( $j == 3 )) && continue 2; 
		# continue 2;那么当$j=3的时候，就退出到最外面循环了，不再执行当前循环！
		echo "$i $j";
	done
done
