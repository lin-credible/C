#!/bin/bash
#

BACKUPDIR="/backup/"	#指定备份目录

DATE=$(date +%F)	#获得系统当前日期: 2011-10-29

TAR="/bin/tar"		#指定备份命令

if [ $ -eq 0 ] 
then
	echo "Usage:"
	echo "./backup1.sh 前缀 备份文件 1.."
	echo 
	exit 1
fi

PRE=$1	#获得第一个参数即前缀

if[ -e $PRE ];
then
	echo "Usage:"
	echo "./backup1.sh 	
