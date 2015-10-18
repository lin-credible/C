#os version: rhel5u5
#bash version: bash3.2
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#function:
#param:
#return: 0
#usage: check_rpm httpd mysql-server php php-mysql
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

check_rpm()
{
	while (( $# > 0 ))
	do
		if ! rpm -q $1 &> /dev/null
		then
			yum install $1 -y &> /dev/null;
			echo "$1 install is success!";
		fi
		shift;
#执行一次shift，就会将最左边的参数去掉一个!所以，每次的
# $1都是最新的!
	done
	return 0;
}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#function:
#param:
#return: 0
#usage: 
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

start_server()
{
	for i in "$@"
	do
		 service $i restart  &> /dev/null;
	         echo "$i start OK!";
	done
	return 0;
}
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#function:
#param:
#return: 0
#usage: 
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

add_user()
{
	if ! id $1 &>/dev/null
	then
		useradd $1
		echo "user $1 create!"
	fi
	return 0;
}

#---------加多个！
add_user_2()
{
	for i in "$@"       #四个参数用 $@ 表示！以空白作为分隔
	do 
		
		if ! id $i &>/dev/null
		then
			useradd $i
			echo "user $i create!"
		fi
	done 
	return 0;
}
 
#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

addDir()
{
	for i in $1{1,2,3,4,5}	#{1,2,3,4,5} 能否接受传参? {1..$2}???
	do
		[ -d "/$i" ] && echo " $i exists!" || mkdir "/$i" &>/dev/null
	done
}

addDir2()
{
	for i in `seq -w $2`
	do
		a=$1${i}
	#	[ -d "/$a" ] && echo " $a exists!" || mkdir "/$a" &>/dev/null
		[ -d "/$a" ] && : || mkdir "/$a" &>/dev/null
	#	[ -d "/$a" ] &&  mkdir "/$a" &>/dev/null
	done
}


