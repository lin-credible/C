#!/bin/bash
#comment
for i in `ls -l | awk '$5>10240{print $8}'`
do
	mv "${i}" /tmp
done
ls -al /tmp
echo 'done';
exit 0;
