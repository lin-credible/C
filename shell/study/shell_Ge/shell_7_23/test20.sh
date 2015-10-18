#!/bin/bash
#comment
a=0;
case $a in
[012])			echo aa;;
3|4|5)			echo bb;;
[a-z]|[A-Z])		echo cc;;
*)			echo dd;;
esac
