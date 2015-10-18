#!/bin/bash
#comment
ip="192.168.0."
for i in "${ip}"{1..254}
do
	(
		ping "$i" -c 1 -i 1 -W 1 &> /dev/null
		if (( $? == 0 ))
		then
			echo "$i is alive"
		fi
	) &
done
wait
exit 0;
