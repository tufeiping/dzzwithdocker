#!/bin/bash

if [ ! -f /.mysql_admin_created ]; then
	/create_mysql_admin_user.sh
fi

/etc/init.d/mysql start

ln -s /var/run/mysqld/mysqld.sock  /tmp/mysqld.sock

exec supervisord -n
