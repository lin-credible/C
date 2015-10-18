#!/bin/bash
#comment
host="192.168.0.222"
user="tom"
pass="aixocm"
ftp -i -n "$host" &> /dev/null << EOF
user "$user" "$pass"
binary
lcd /tmp
put file1
cd /etc
get fstab
bye
EOF
