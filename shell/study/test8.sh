#echo $#
#for i in "$*"
#do
#	echo $1;
#done 

abc()
{
	a=800;
	return $a;
}
abc
echo $?
