#!/bin/bash

# ls -l 中的文件的大小的默认单位是 Byte
for i in `ls -l | awk '$5>10240{print $8}'`
do
	mv "${i}" /tmp
done
ls -l /tmp
echo 'done';
exit 0;
