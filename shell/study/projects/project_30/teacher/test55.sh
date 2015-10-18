#!/bin/bash #comment
cd /var/www/html/
for i in *.HTM		#注意，不能在 *.HTM 后面加引号，也不要使用 `ls *.HTM`(若文件中有空格，会出问题!)
do
	mv $i $( echo $i | sed 's/\.HTM/\.htm/' )
done
