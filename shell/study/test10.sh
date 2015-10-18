read -p "How old are you: " age
if (( age <= 0 || age >= 120 ))
then
	echo "Error"
#	exit 10;
	return 10
#	return->1:用source命令执行;2:将return 用于函数中!
#+	否则，将不能成功退出脚本！
#????是不是 exit 退出的是 shell! 而return 退出的只是 脚本??
fi
date
