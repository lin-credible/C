grep -v "^#" /etc/hosts | grep -v "^$">file1 
while read ip hosts
do
	echo "$ip -> $hosts"
done <file1
