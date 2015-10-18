#!/bin/bash
#comment
a=3;
until [ $a -lt 0 ] #(( a < 0 ))
do
	echo $a;
	a=$[ $a - 1 ]; #(( a-- )) let a--
done
