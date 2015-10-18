#!/bin/bash
# 
#for i in "$@"
#do
#	if [ -d "$i" ] 
#	then
#		if [[ "$i" == "." || "$i" == ".." ]]
#		then
#			echo "Skipping ...";
#		else
#			j=`basename ${i}`  #去掉路径名!剩下文件名!
#			tar czvf ${j}.tar.gz $i
#		fi
#	else
#		echo "$i is not a directory!"
#	fi
#done

#-----------------------------------------------------
#取出 /opt 下面所有属于 用户 tom等的用户创建的文件多于20的用户，打印警告信息!

#dir1="/opt"
#lmt=20
#u=$( grep "/bin/bash" /etc/passwd | cut -d: -f1 )
#for i in $u
#do
#	num=$( find $dir1 -user $i | wc -l )
#	if (( num > lmt ))
#	then 	
#		echo "$i file name > $lmt"
#	fi
#done
#----------------------------------------------------------------
# 注释!
# su - tome
# cd /opt
#touch /opt/file{1..5} 权限不够
#------------
# su - root
# touch /opt/file{1..5}
# chown tom /opt/file?

#===============================================================
#for i in `seq -w 10`
for i in `seq  10`
do
	echo $i;
done



