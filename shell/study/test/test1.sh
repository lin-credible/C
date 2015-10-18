#!/bin/bash
# 执行脚本的时候，需要传参数!
#for i in $*
#do
#	echo $i;
#done
echo ------------------------------
for i 
do	
	[ -x $i ]  && echo "OK" || echo "NO";
done
