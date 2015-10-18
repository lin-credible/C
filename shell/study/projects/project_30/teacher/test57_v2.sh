#!/bin/bash
#comment
while read user group
do
	echo $group
done < user.list > file1 

tr "," "\n" < file1 > file2
sort file2 | uniq > file3

while read group
do
	if ! grep "$group" /etc/group &> /dev/null
	then
		groupadd $group
	fi
done < file3

while read user group
do
	pwd=$( awk '$1==un{print $2}' un=$user passwd.list )

	mg=`echo $group | cut -d, -f1`
	if ! id $user &> /dev/null
	then
		useradd $user -g $mg
		echo "$pwd" | passwd $user --stdin &> /dev/null
	fi
	gl=( `echo $group | tr "," " "` )
	i=1
	while (( i < ${#gl[@]} ))
	do
		gpasswd -a $user ${gl[i]} 
		(( i++ ))
	done
done < user.list
