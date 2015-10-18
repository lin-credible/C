#!/bin/bash
#comment
dir="/var/lib/mysql"
file="/tmp/dbinfo.txt"
backFile="/opt/mysql.bak.`date +%F`.tar"

date +%F-%T >> $file
du -sh "${dir}" >> $file
cd ${dir}/..

tar cf $backFile `basename $dir`
cd `dirname ${file}`
tar rf $backFile `basename $file`
[ ! -e "$backFile" ] && bzip2 $backFile

rm -f $file
