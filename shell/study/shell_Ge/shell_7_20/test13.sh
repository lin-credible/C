#!/bin/bash
#comment
ls -l `find /etc -name "*.conf"` | awk '{print $5}' > file1
rs=0
while read s
do
	(( rs+=s ))	
done < file1
echo "$rs"
