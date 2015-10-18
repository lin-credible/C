#!/bin/bash
#comment
#for i
#do
#	if [ -d "$i" ]
#	then
#		if [[ "$i" == "." || "$i" == ".." ]]	
#		then
#			echo "skipping...";
#		else
#			j=`basename ${i}`
#			tar czf ${j}.tar.gz $i 
#		fi
#	else
#		echo "$i is not a dir";
#	fi
#done

#dir1="/opt"
#lmt=4
#u=$( grep "/bin/bash" /etc/passwd | cut -d ":" -f1  )
#for i in $u
#do
#	num=$( find $dir1 -user $i | wc -l)
#	if (( num > lmt ))
#	then
#		echo "$i file number > $lmt"
#	fi
#done

#rs=0;
#while (( $# > 0 ))
#do
#	(( rs+=$1 ))
#	shift
#done
#echo "$rs"

#for i in `seq 6`
#do
#	if (( i % 2 == 0 ))
#	then
#		continue; #break;
#	fi
#	echo "$i";
#done
#echo "over"
#
#
for (( i=1; i<=5; i++ ))
do
	for (( j=1; j<=3; j++ ))
	do
		(( $j == 2 )) && continue; #continue 2 break 2
		echo "$i $j";
	done
done
