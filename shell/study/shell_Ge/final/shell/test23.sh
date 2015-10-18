#!/bin/bash
#comment
abc()
{
	if [[ "$1" =~ "abc" ]]	
	then
		echo 'ok';
	else
		echo -n "error, input: ";
		read ip;
		abc "$ip"
	fi
}
abc $1
