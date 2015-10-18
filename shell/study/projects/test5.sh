#!/bin/bash
#
#注意，这个要求ssh进行秘钥认证!
warn=80
ip=( 192.168.0.210 192.168.0.210 192.168.0.210 );
for i in "${ip(@)}"
do
	ssh root@$i df -Th > /tmp/file1
	grep "^/dev" /tmp/file1 | awk '{print $1,$6}' | tr -d "%" > /tmp/file2
	awk '{if($2>w) print $1" usage > " w }' w=$warn /tmp/file2
done
