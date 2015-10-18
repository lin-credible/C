#!/bin/bash
#comment
grep -v "^#" /etc/hosts > file1
while read ip hosts
do
	echo "$ip -> $hosts"
done < file1
