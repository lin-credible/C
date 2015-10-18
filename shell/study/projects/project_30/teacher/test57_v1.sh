#!/bin/bash
#comment
#
#while用得是不是太多了!
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
	pwd=$(grep "$user" passwd.list | awk '{print $2}')	#这样取密码，不严谨!关键是 grep 不严谨!#应该用 awk 去截取!
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
