#!/bin/bash
#comment
for i in *.HTM
do
	mv $i $( echo $i | sed 's/\.HTM/\.htm/' )
done
