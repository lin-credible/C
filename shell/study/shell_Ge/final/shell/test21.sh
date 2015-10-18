#!/bin/bash
#comment
select var in "linux" "unix" "macos" "windows"
do
	break;
done
echo "you select is $var";
