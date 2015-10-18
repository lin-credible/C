#!/bin/bash
#comment
for i in $( find /root -maxdepth 1 -type f )
do
	if grep -qw "dskj" "$i"
	then
		echo "$i"
		grep -nw "dskj" "$i" --color=auto
		echo "------------------------------------"
	fi
done
