#!/bin/bash
#comment

#vim /var/lib/nfs/etab
#showmount -a localhost

#client:
#insall portmap
#service portmap start
#showmount -e serverIP
#mount -t nfs serverIP:/dir1 /mnt

. lib.sh
checkRPM portmap nfs-utils

cat > /etc/exports << EOF
/dir1	*(ro,all_squash)
/dir2	*.ds.com(rw,sync)
#/dir3	server1.ds.com(rw)
/dir4	192.168.0.0/24(rw,sync)
/dir5	192.168.0.1(rw,anonuid=500,anongid=500) 
/dir6	192.168.0.2(ro) 192.168.0.3(rw)
EOF

addDir dir 6

config1="/etc/hosts.allow"
config1Bak="/etc/hosts.allow.bak"
config2="/etc/hosts.deny"
config2Bak="/etc/hosts.deny.bak"

[ ! -f "$config1Bak" ] && cp $config1 $config1Bak
cp $config1Bak $config1 

[ ! -f "$config2Bak" ] && cp $config2 $config2Bak
cp $config2Bak $config2 

echo "portmap:192.168.0.0/255.255.255.0" >> $config1
echo "portmap:all" >> $config2

startS portmap nfs
