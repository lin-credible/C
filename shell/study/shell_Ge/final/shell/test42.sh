#!/bin/bash
#comment
logDir="/var/log"
logs=( messages maillog "httpd/access_log" ) #自定义
for i in "${logs[@]}"
do
	echo '' > "$logDir/$i"
done && echo "Done"
exit 0
