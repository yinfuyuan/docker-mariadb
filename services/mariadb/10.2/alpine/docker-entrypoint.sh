#!/bin/sh

# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
	set -- mysqld "$@"
fi

chown -R mysql:mysql /usr/local/mysql

cd /usr/local/mysql && ./scripts/mysql_install_db -umysql

exec "$@"