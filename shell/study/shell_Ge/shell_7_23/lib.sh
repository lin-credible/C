#os version: rhel5u5
#bash version: bash3.2
#可复用

# -----------------------------------------------
# function: 
# param: 
# return: 0
# usage: checkRPM httpd mysql-server php 
# -----------------------------------------------
checkRPM()
{
	while (( $# > 0 ))
	do
		if ! rpm -q $1 &> /dev/null
		then
			yum install $1 -y &> /dev/null;
			echo "$1 install is success!";
		fi
		shift;
	done
	return 0;
}

# -----------------------------------------------
# function: 
# param: 
# return: 0
# usage: 
# -----------------------------------------------
startS()
{
	for i in "$@"
	do	
		service $i restart &> /dev/null
		echo "$i start ok!";
	done	
	return 0;
}

# -----------------------------------------------
# function: add user
# param: 
# return: 0
# usage: 
# -----------------------------------------------
au()
{
	for i in "$@"
	do
		if ! id $i &> /dev/null
		then
			useradd $i;
			echo "user $i create!";
		fi		
	done
	return 0;
}

# -----------------------------------------------
# function: add directory
# param: 
# return: 0
# usage: addDir ds 5
# -----------------------------------------------
addDir()
{
	# ---------------------------------------
	# 方法1 for
	#for i in `seq -w $2`
	#do
	#	dir="$1$i"
	#	[ ! -d "/${dir}" ] && mkdir "/${dir}" && echo "/${dir} create ok!";
	#done
	#return 0;
	# ---------------------------------------
	# 方法2 while
	i=1;
	while (( i <= $2 ))
	do
		dir="$1$i"
		[ ! -d "/${dir}" ] && mkdir "/${dir}" && echo "/${dir} create ok!";
		let i++;
	done
	return 0;
}

