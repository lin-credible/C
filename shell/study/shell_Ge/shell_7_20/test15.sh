#!/bin/bash
#comment
fun1()
{
  [ ! -d $1 ] && { mkdir $1; echo "$1 create ok!"; } || echo "$1 exist";
}
a=20
while (( a > 0 ))
do
	if (( a < 10 )); then
		b="0$a";
		fun1 "dir$b";
	else
		fun1 "dir$a"
	fi
	(( a-- ));
done
