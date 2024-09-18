#!/bin/bash

echo "Creating necessary directories..."
mkdir -p /run/mysqld
mkdir -p /var/www/db

echo "Setting permissions for MySQL..."
chown -R mysql:mysql /var/run/mysqld

echo "Starting MySQL..."
mysqld &

echo "Waiting for MySQL to start..."
until mysqladmin ping --silent; do
    echo "MySQL is not ready yet, waiting..."
    sleep 1
done

echo "MySQL is ready."

echo "Creating SQL initialization script..."
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWD';" > /tmp/init.sql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" >> /tmp/init.sql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' ;" >> /tmp/init.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> /tmp/init.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;" >> /tmp/init.sql
echo "FLUSH PRIVILEGES;" >> /tmp/init.sql

echo "Applying SQL commands..."
mysql < /tmp/init.sql
if [ $? -eq 0 ]; then
    echo "SQL commands applied successfully."
else
    echo "Failed to apply SQL commands."
    exit 1
fi

echo "Stopping MySQL..."
pkill mysqld

echo "Restarting MySQL..."
mysqld

