abc()
{
	echo $@;
	echo $#;
}
#abc 11 22 33
#abc $1 $2 $3
abc $@
