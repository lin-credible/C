#!/bin/bash
#os version:rhel5u5
#bash version:bash3.2
check_rpm()
{
	! rqm -q samba &>/dev/null  && yum install samba -y &>/dev/null
	#&&这种写法叫做列表的形式!
	return 0;
}

#	make && make install || echo fail!
#	列表形式！如果make成功，执行 make install!
#		  如果make失败，执行 echo fail!
check_rpm_1()
{
	if ! rpm -q $1 &> /dev/null
	then
		yum install $1 -y &> /dev/null;
		echo "$1 install is success!";
	fi
	return 0;
}

check_rpm_2()
{
	varl=10
	while (( varl > 0 ))
	do
		echo $varl;
		let varl--;	
	done
#	if ! rpm -q $1 &> /dev/null
#	then
#		yum install $1 -y &> /dev/null;
#		echo "$1 install is success!";
#	fi
#	return 0;
}

check_rpm_3()
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
#check_rpm      调用第一个函数
#check_rpm_1 samba  # 参数 samba 对应就是$1!
#check_rpm_2   测试while!
check_rpm_3 httpd mysql-server php php-gd php-mysql
