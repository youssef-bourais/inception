#!/bin/sh

echo "Creating necessary directories..."
mkdir -p /run/php/
mkdir -p /var/www/html/

echo "Updating PHP-FPM configuration..."
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

echo "Changing to the web root directory..."
cd /var/www/html/
#rm -rf *

echo "Downloading WP-CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp


if [ -f /var/www/html/wp-config.php ]; then
	echo "Wp already Config already there...."
else
	rm -rf *
	echo "Downloading WordPress core..."
	wp core download --allow-root
	if [ $? -eq 0 ]; then
	    echo "WordPress core downloaded successfully."
	else
	    echo "Failed to download WordPress core."
	    exit 1
	fi

	echo "Creating WordPress configuration..."
	wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD --dbhost=mariadb --allow-root
	if [ $? -eq 0 ]; then
	    echo "WordPress configuration created successfully."
	else
	    echo "Failed to create WordPress configuration."
	    exit 1
	fi

	echo "Installing WordPress..."
	wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	if [ $? -eq 0 ]; then
	    echo "WordPress installed successfully."
	else
	    echo "Failed to install WordPress."
	    exit 1
	fi
	#echo "Updating WordPress options..."
	#wp option update siteurl "https://localhost" --allow-root
	#wp option update home "https://localhost" --allow-root

	if [ $? -eq 0 ]; then
	    echo "WordPress options updated successfully."
	else
	    echo "Failed to update WordPress options."
	    exit 1
	fi

	echo "Creating WordPress user..."
	wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWD --allow-root
	if [ $? -eq 0 ]; then
	    echo "WordPress user created successfully."
	else
	    echo "Failed to create WordPress user."
	    exit 1
	fi
fi

chown -R www-data:www-data /var/www/html/*
chmod -R 755 /var/www/html/*

echo "Starting PHP-FPM..."
php-fpm7.4 -F


