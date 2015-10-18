#!/bin/bash
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# rpm-check.sh
#
#Destination: 为了描述，列表，和确定是否可以安装一个rpm包
#在一个文件中保存输出
#这个脚本使用一个代码块来展示
#这个没弄成！！对脚本的没怎么理解！basename???
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

SUCCESS=0
E_NOARGS=65

if [ -z "$1" ]
then	
	echo "Usage: `basename $0` rpm-file"
	#shell>basename $0 ///输出结果为:bash
	exit $E_NOARGS
fi

{
	echo "----------------------"
	echo "Archive Description:"
	rpm -qpi $1	#查询说明
	echo "----------------------"
	echo "Archive Listing:"
	rpm -qp1 $1	#查询列表
	echo "----------------------"
	rpm -i --test $1 #查询rpm包是否可以被安装.
	if [ "$?" -eq $SUCCESS ]
	then
		echo "$1 can be installed."
	else
		echo "$1 cannot be installed."
	fi
	echo "-----------------------"
} > "$1.test"	# 把代码块中的所有输出都重定向到文件中.

echo "Results of rpm test in file $1.test"
# 查看 rpm 的 man 页来查看 rpm 的选项！
exit 0


