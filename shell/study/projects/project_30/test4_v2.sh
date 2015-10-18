#!/bin/bash
#
#将　/var/www/html下 *.HTM 改为　*.htm
#==============版本2
dir="/var/www/html"
file=(`ls /var/www/html/ | grep ".HTM$" | tr "\n" " "`)
cd $dir
#生成去掉了 HTM后的文件名数组
for (( i=0;i<${#file[*]};i++))
do
	echo ${file[i]:0:((`echo ${#file[i]}`-4))} >>file1
done
for i in `cat $dir/file1`
do
	mv $i.HTM $i.htm	
done
exit 
