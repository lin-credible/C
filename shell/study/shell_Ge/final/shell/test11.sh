#!/bin/bash
#comment
while :
do
	read -p "input a num: " str
	echo $str >> /tmp/file1;
	if [[ $str == "END" ]]; then
		break;
	fi
done
wc /tmp/file1
rm -f /tmp/file1
