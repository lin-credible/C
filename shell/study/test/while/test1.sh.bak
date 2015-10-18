while read user group home
do
	echo -e "\$user=$user\t\$gid=$group\t\$home=$home"
	gid=$( echo $group | cut -d "," -f1 )
	echo "\$gid=$gid"
	sleep 2; 	# 系统休息两秒钟，再继续运行!
done < file1
