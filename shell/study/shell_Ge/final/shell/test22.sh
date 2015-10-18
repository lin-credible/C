#!/bin/bash
#comment
PS3="please select: "
select var in "linux" "unix" "macos" "windows" "quit"
do
	case $var in
	linux)		
			echo "you select is linux"
			date
			cal
			ls
			;;
	unix)		echo "you select is unix";;
	macos)		echo "you select is macos";;
	quit)		exit 0;;
	*)		echo "wrong";;
	esac
done
