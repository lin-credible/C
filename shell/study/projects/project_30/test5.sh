#!/bin/bash
#
#-----基本符合要求了!-----------------
#获取参数
#var1=${*:1:2} #为什么这样做 $var1 显示不出单引号呢？直接echo $2也一样!
var1=${*:1:2}
var2=${*:(-1)}
#echo $var1
#echo $var2

#============================
#需要改进的地方!
#1: 数据库创建的时候没有设置关键字~想更完美，需要将数据库表建好一些!
#2: rs.txt 没有判断重复的追加?
#==========================


#先生成符合要求的数据格式！
#暂时先省略这一步，那么就要求用户进行配合了!
#id.list 中的数据格式要是: 01 'linux'-->由于获取的参数，获取不了单引号，
#+故只能重新考虑了!id.list不能有 'linux'，插入要数据库的时候再加上单引号吧!
#并且作为参数传递进来的时候，也要是这样!
while read a;do arr[x++]="${a}";done <$var2
for ((i=0;i<${#arr};i++))
do
	if [[ ${arr[i]} == $var1 ]]
	then
		#插入数据库
		mysql -e "use ds;insert into table1 values ($1,'$2');"
		break;	
	#else
		#怎么让这条命令只执行一次
		#想到了一个奇怪的方法!
		#执行了一次之后，将文件的权限设置为不可写!循环过后，再恢复！
#		echo $var1 >> rs.txt
#		chmod 000 rs.txt &> /dev/null
	fi
done
#chmod 644 rs.txt
#纳闷了，竟然不行?why?
#exit这个地方没有看到呀!擦～～～

#-----------------------
#发现了，向 rs.txt里面添加数据，需要另写一个循环去控制！
#判断函数，是否可以添加数据到rs.txt中!
add_rs()
{
	for ((i=0;i<${#arr};i++))
	do
		if [[ ${arr[i]} != $var1 ]]
		then
			continue;
		else
			exit 1;
		fi
		exit 0;
	done
}
if add_rs ${arr[@]}
then
	echo $var1 >>rs.txt	
fi
#=========怎么回事儿？rs.txt这个文件却不出现了？
#------擦～原来是上面的 exit 没有注释掉！
