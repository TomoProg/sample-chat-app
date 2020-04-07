#!/bin/bash

mysql -h localhost -p${MYSQL_ROOT_PASSWORD} -u root -e "CREATE USER ${DB_USER} IDENTIFIED BY '${DB_PASS}';" || exit 10
mysql -h localhost -p${MYSQL_ROOT_PASSWORD} -u root -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';" || exit 11
mysql -h localhost -p${MYSQL_ROOT_PASSWORD} -u root -e "GRANT ALL ON ${DB_NAME}_test.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';" || exit 12

echo "Success!"
