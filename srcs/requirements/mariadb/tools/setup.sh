#!/bin/bash

set -e

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then

    mysqld_safe --datadir=/var/lib/mysql &
    pid="$!"

    until mysqladmin -u root ping --silent; do
        sleep 1
    done

    mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.*TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown
    wait "$pid"
fi

exec mysqld_safe --datadir=/var/lib/mysql