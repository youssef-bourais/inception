#!/bin/sh

mkdir -p /run/php/

mkdir -p /var/www/html/

sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

cd /var/www/html/

rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWD --dbhost=mariadb --allow-root 
#--extra-php <<PHP
#define( 'WP_DEBUG', true );
#define( 'WP_DEBUG_LOG', true );
#PHP
#
#mv /var/www/wp-config.php .

#sed -i -r "s/db33/$DB_NAME/1"   wp-config.php
#sed -i -r "s/user33/$DB_USER/1"  wp-config.php
#sed -i -r "s/passwd/$DB_PASSWD/1"    wp-config.php

wp core install --url="https://$DOMAIN_NAME" --title="$WP_TITLE" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

#wp option update siteurl "https://$DOMAIN_NAME" --allow-root
#wp option update home "https://$DOMAIN_NAME" --allow-root

#wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWD --allow-root

#wp plugin update --all --allow-root

php-fpm7.4 -F

