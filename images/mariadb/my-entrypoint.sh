#!/bin/bash

# It is workaround for windows
# The goal: Have a modifiable MariaDB/MySQL config file on host machine
# Obvious solution: Mount that file in compose yaml file as `/etc/mysql/conf.d/my-mariadb.cnf`
# The problem: Files mounted from windows have access rights 777 and MariaDB/MySQL does not like it
# Solution:
#	- Mount config from host file to temp file `/my-mariadb-tmp.cnf`
#	- Every time a container starts - copy that file to `/etc/mysql/conf.d/my-mariadb.cnf` and set it access rights 644 (in custom entrypoint file)
#	- Run parent's container entrypoint file

cp -f /my-mariadb-tmp.cnf /etc/mysql/conf.d/my-mariadb.cnf
chmod -v 664 /etc/mysql/conf.d/my-mariadb.cnf

. /docker-entrypoint.sh