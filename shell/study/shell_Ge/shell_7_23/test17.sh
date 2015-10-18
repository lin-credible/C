#!/bin/bash
#comment
until (( $# <= 0 ))  #[ -z $1 ]
do
	echo "$# $*"
	shift;
done
