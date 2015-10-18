#!/bin/bash
#-----------------------------------------------
. lib.sh   #调用lib.sh!这个库，. 执行！不需可执行权限！
#----------------------------------------------
check_rpm samba
#----------------------------------------------

cd /etc/samba

configFile="/etc/samba/smb.conf"
configFileBack="/etc/samba/smb.conf.bak"
#--------用变量来代替下面的文件名
[ ! -f smb.conf.bak ] && cp smb.conf smb.conf.bak
cp smb.conf.bak smb.conf
sed -i 's/^\s*security =.*/\tsecurity = xyz/' smb.conf
sed -i '/hosts allow/s/^.*$/\thosts allow = 127. 192.168.20.0\/24/' smb.conf
[ ! -d /ds ] && mkdir /ds
cat >>smb.conf <<EOF
[ds]
path = /ds
public = yes
writable = no
EOF
#------------------------------------------------
#----add user----------------------
#add_user mike
add_user_2 mike john jerry lee
#echo "Please execute smbpasswd -a mike!"
####这个交互需要用 expect 处理！
pa="aixocm"
for i in mike john jerry lee
do 
	./test1.exp $i $pa &>/dev/null
	echo "samba user $i create OK!";
done

#---------------------------------------
start_server smb
#--------------------------------------------------
exit 0
