#!/bin/bash
# escaped.sh: 转义符

echo;echo

echo "\v\v\v\v"
echo "============="
echo "VERTICAL TABS"
echo -e "\v\v\v\v"
echo "============="

echo "QUOTATION MARK"
echo -e "\042"
echo "============"

echo; echo "NEWLINE AND DEEP"
echo $'\n'
echo $'\a'
echo "================"
echo "QUOTATION MARKS"
echo 
