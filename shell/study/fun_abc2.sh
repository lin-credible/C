abc()
{
	if [[ "$1" =~ "abc" ]]
	then
		echo "OK";
	else
		echo -n "Error,Input:";
		read ip;
		abc "$ip";
	fi
}
abc $1
