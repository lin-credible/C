#!/bin/bash
#
rs=0;
for i
do
	(( rs+=$i ))
done
echo "$rs"
echo ==============================
rt=0
while (( $# > 0 ))
do
	(( rt+=$1 ))
	shift
done
echo "$rt"
