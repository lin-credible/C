#!/bin/bash
#comment
until wget -q http://www.ds.com/index.html
do
	sleep 30;
done
echo ok;
exit 0;
