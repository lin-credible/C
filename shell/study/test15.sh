a=10
until [ $a -le 0 ]
do
	echo $a
	a=$[ $a - 1 ]
done
