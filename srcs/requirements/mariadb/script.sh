#!/bin/bash

mkdir -p /run/mysqld

mkdir -p /var/www/db

chown -R mysql:mysql /var/run/mysqld

mysqld &

echo "Waiting for MySQL to start..."
until mysqladmin ping --silent; do
    sleep 1
done

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWD';" > /tmp/init.sql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" >> /tmp/init.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' ;" >> /tmp/init.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> /tmp/init.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;" >> /tmp/init.sql
echo "FLUSH PRIVILEGES;" >> /tmp/init.sql

echo "Applying SQL commands..."
mysql < /tmp/init.sql

pkill mysqld

mysqld

