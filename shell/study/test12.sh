#!/bin/bash
#
#for day in "monday" "friday" "sunday"
#do
#	echo $day;
#done
#
#for i in `cat file1` #循环取出的是file1中的4行内容!一行里面，一空白隔开的也行!
#do
#	echo $i;
#done

#for i in ./*.sh # 遍历了当前目录下所有的以sh结尾的文件!
#do	
#	echo $i;
#done

for i in $( find . -name "*.sh" | grep -i "8" )
do
	echo $i;
done
