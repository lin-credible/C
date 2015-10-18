#!/bin/bash
#comment
path=$( echo $PATH | tr ":" " " )
file=$( find $path -type f 2> /dev/null )
for i in $file
do
	[ -u "$i" ] && ls -l "$i"
done
