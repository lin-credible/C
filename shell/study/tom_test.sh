test()
{
	if grep "\<tom\>" /etc/passwd &> /dev/null
	then 
		echo tom exist!
	fi
}
test

echo "========================"

config="/etc/passwd";
test1()
{
	if grep "\<$1\>" $config &> /dev/null
	then 
		echo $1 exist!
	fi
}
test1 tom

echo "====================="
cat > file1 << EOF
abc
def
EOF
