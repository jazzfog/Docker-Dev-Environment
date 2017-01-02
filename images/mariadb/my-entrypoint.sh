#!/bin/bash

echo "MariaDB: Copying config...";

cp -f /my-mariadb-tmp.cnf /etc/mysql/conf.d/my-mariadb.cnf

echo "MariaDB: Changing privileges...";

chmod -v 664 /etc/mysql/conf.d/my-mariadb.cnf

# Execute original script from parent image
. /docker-entrypoint.sh