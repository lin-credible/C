#  > ---gt  
#  <= ---le

#if [ 5 -gt 4 ]
#then
#	echo '>';
#fi

#if test 5 -gt 4 
#then 
#	echo ">";
#fi

var1="abc"
if [ "$var1" == "abc" ]  #假如 var1里面有空格，就需要 "$var1", 不然比较会失败！
then 
	echo "=="
fi

var2="def"
if [[ "$var2" == "def" ]]  #假如 var1里面有空格，就需要 "$var1", 不然比较会失败！
then 
	echo "=="
fi
