#!/bin/bash
#comment
flag=0
while read id content
do
	if [[ "$id" == "$1" ]]	
	then
		mysql -e "use mis; insert into table1 values ($1, '$2')"
		flag=1
	fi
done < id.list

if (( flag == 0 ))
then
	echo "$1 $2" >> rs.txt
fi
