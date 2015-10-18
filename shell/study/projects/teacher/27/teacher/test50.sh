#!/bin/bash
#comment
#备份，用相对路径!

touch sx 

backDir="/backup2"
[ ! -d $backDir ] && mkdir "$backDir"

pre="$1"
fileName=${backDir}/${pre}.`date +%F`.tar
tar cf $fileName sx

shift

checkFile()
{
	for file in "$@"
	do
		if [ ! -e $file ]
		then
			echo "Error: $file is not found."
			rm -f $fileName
			exit 1;
		fi
	done
}
checkFile "$@"

for file in "$@"
do
	if echo $file | grep "^/" &> /dev/null
	then
		cd `dirname $file` 
		tar rf $fileName `basename $file` 
	else
		tar rf $fileName $file
	fi
done
tar f $fileName sx --delete
