#!/bin/bash
#comment
[ ! -d "/tmp/index" ] && mkdir /tmp/index
find /usr/share/doc -name index.html > file1

i=1
while read f
do
	cp -pv $f /tmp/index/index.html.$i
	(( i++ ))
done < file1
