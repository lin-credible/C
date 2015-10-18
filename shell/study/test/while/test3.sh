#!/bin/bash
# 求出所有文件的大小之和!
echo ---------------------------way 1!
size=$( ls -l `find /etc -name "*.conf"` | awk '{print $5}' )
echo $size | tr " " "+" | bc
echo ---------------------------way 2!
ls -l `find /etc -name "*.conf"` | awk '{print $5}' >file1
#echo $size | tr " " "\n" > file1
rs=0
while read s
do
	(( rs+=s ))
done < file1
echo "$rs"
echo ----------------------------way 3!
# for 循环 !

