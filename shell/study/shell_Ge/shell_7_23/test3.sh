#!/bin/bash
#comment
#while (( $# > 0 ))
#do
#	echo $1;
#	shift;
#done

#for i in "$@"
#do
#	echo $i;
#done

i=1;
while (( i <= $# ))
do
	echo ${!i};  #间接引用  
	let i++;
	#(( i++ ))
done
