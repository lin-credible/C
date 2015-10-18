#until [ -z $1 ]
until (( $# <= 0 ))
do
	echo "$# $*"
	shift;
done
