#!/bin/bash
#auto install source code software
#ins.sh
rpm -q gcc gcc-c++ make > /dev/null || { echo 'please install gcc gcc-c++ make!'; exit 10; };
DIR1='/usr/local/src/';
case $1 in
*.tar.gz)
	tar zxf $1 -C $DIR1;;
*.tar.bz2)
	tar jxf $1 -C $DIR1;;
*)
	echo 'please input a tar.gz or tar.bz2 file!';
	exit 20;;
esac
FOLDER=`ls $DIR1`;
cd $DIR1/$FOLDER;
echo './configure is starting...';
./configure --prefix=/usr/local/nload2 > /dev/null;
echo './configure is down.';
make > /dev/null;
make install > /dev/null;
