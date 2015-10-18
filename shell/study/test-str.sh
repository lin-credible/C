#!/bin/bash
#

if [ -n $string1 ]
then
	echo "String \" string1\" is not null." 
	#结果是这个!
else
	echo "String \" string1\" is null."
fi

echo ======================

if [ -n "$string1" ]
then
	echo "String \" string1\" is not null." 
else
	echo "String \" string1\" is null."
	#结果是这个!
fi

echo ======================

if [ "$string1" ]
then
	echo "String \" string1\" is not null." 
else
	echo "String \" string1\" is null."
	#结果是这个!
fi

echo ======================


