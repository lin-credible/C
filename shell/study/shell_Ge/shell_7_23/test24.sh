#!/bin/bash
#comment
a=100
fun1()
{
	echo $a;
	local b=200
}
fun1
echo $b;
