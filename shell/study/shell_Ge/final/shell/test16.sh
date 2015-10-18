#!/bin/bash
#comment
until [ -e /var/lib/mysql/mysql.sock ]
do
	service mysqld start
done
