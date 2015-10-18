#!/bin/bash
#comment
logDir="/var/log"
logs=( messages maillog "httpd/access_log" ) #自定义
for i in "${logs[@]}"
do
	echo '' > "$logDir/$i"	#用空覆盖日志文件，也即清空!
done && echo "Done"
exit 0
