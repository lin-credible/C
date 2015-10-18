#!/bin/bash
#commnet
while read user group home
do
	echo -e "\$user=$user\t\t\$gid=$group\t\t\$home=$home"
	gid=$( echo $group | cut -d "," -f1 )
	echo "\$gid=$gid"
	sleep 2;
done < file1
