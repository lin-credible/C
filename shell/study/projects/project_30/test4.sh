#!/bin/bash
#
#将　/var/www/html下 *.HTM 改为　*.htm
#==============版本一
dir="/var/www/html"
cd $dir
for i in `ls $dir | grep ".*.HTM$" | awk -F "." '{print $1}' | tr "\n" " "`
do
	mv $i.HTM $i.htm	
done
exit 
