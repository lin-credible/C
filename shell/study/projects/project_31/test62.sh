#!/bin/bash
#comment
ip="192.168.0.222"
un="tom"
pa="aixocm"
dir="tomDir"
ldir="/opt"
files="abc.txt xyz.doc"

ftp -in $ip << EOF &> /dev/null
user $un $pa
binary
cd $dir
lcd $ldir
mget $files
bye
EOF
