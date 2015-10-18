#!/bin/bash
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# vim /var/lib/nfs/etab ///这个文件的内容很给力的哦！
#+ /etc/exports里面的配置项就很容易写了！
# Client:
#install portmap
#service portmap start
#showmount -e serverIP
#mount -t nfs serverIP:/share  /mount_point
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


. lib.sh
check_rpm portmap nfs-utils

cat > /etc/exports << EOF
/myshare1 	*(ro,all_squash,sync)
#/myshare2 	*.ds.com(rw,sync)
#/myshare3 	server1.ds.com(rw)
/myshare4 	192.168.0.2(rw,anonuid=500,anongid=500)


EOF

addDir2 myshare 4

config1="/etc/hosts.allow"
config2="/etc/hosts.allow.bak"
config3="/etc/hosts.deny"
config4="/etc/hosts.deny.bak"
[ ! -f "$config2" ] && cp $config1 $config2
cp $config2 $config1
echo "portmap:192.168.0.0/255.255.255.0" >> $config1

[ ! -f "$config4" ] && cp $config3 $config4
cp $config4 $config3
echo "portmap:all" >> $config3
# 注意，还需要加上访问控制! hosts.allow, host
# 如果执行多次脚本的话，会添加多次！？？？这个 怎么解决？？？

start_server portmap nfs
