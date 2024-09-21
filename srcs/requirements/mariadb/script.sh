#!/bin/bash

echo -e "Creating necessary directories..."
mkdir -p /run/mysqld
mkdir -p /var/www/db

echo -e "Setting permissions for MySQL..."
chown -R mysql:mysql /var/run/mysqld

echo -e "Starting MySQL..."
mysqld &

echo -e "Waiting for MySQL to start..."
until mysqladmin ping --silent; do
    echo "MySQL is not ready yet, waiting..."
    sleep 1
done

echo -e "MySQL is ready."

#mysql -u root -p$DB_ROOT_PASSWD -e "SHOW DATABASES LIKE '$DB_NAME'" > /dev/null 2>&1

#if [ $? -eq 1 ]; then
#
#

RESULT=`mysql -u$DB_USER -p$DB_PASSWD -e "SHOW DATABASES" | grep $DB_NAME`
if [ "$RESULT" == "$DB_NAME" ]; then
    echo "Database exist"
else
    echo "Database does not exist"
    echo -e "Creating SQL initialization script..."
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWD';" > /tmp/init.sql
    echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" >> /tmp/init.sql
    echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD' ;" >> /tmp/init.sql
    echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> /tmp/init.sql
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD' WITH GRANT OPTION;" >> /tmp/init.sql
    echo "FLUSH PRIVILEGES;" >> /tmp/init.sql
    echo -e "Applying SQL commands..."
    mysql < /tmp/init.sql

    if [ $? -eq 0 ]; then
        echo -e "SQL commands applied successfully."
    else
        echo "Failed to apply SQL commands."
        exit 1
    fi
fi

echo -e "Stopping MySQL..."
pkill mysqld

echo -e "Restarting MySQL..."
mysqld
