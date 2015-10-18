#!/bin/bash
#comment
. lib.sh
checkRPM samba

configFile="/etc/samba/smb.conf"
configFileBack="/etc/samba/smb.conf.bak"

[ ! -f "$configFielBack" ] && cp "$configFile" "$configFileBack"
cp "$configFileBack" "$configFile"

sed -i 's/^\s*security =.*/\tsecurity = user/' $configFile
sed -i '/hosts allow/s/^.*$/\thosts allow = 127. 192.168.0.0\/24/' $configFile
[ ! -d /ds ] && mkdir /ds

cat >> $configFile << EOF
[ds]
path = /ds
public = yes
writable = no
EOF

# ---------------------------------
# add user
au tom jerry mike lee
pa="aixocm"
for i in tom jerry mike lee
do
	./test3.exp $i $pa &> /dev/null;
	echo "samba user $i create ok!";
done

# ---------------------------------

startS smb
exit 0
