#!/bin/bash
#comment
ip="192.168.0.222"
un="tom"
pa="aixocm"
dir="tomDir"
ldir="/opt"
files="abc.txt xyz.doc"
lftp -u $un,$pa $ip << EOF
cd $dir
lcd $ldir
mget $files
exit
EOF
