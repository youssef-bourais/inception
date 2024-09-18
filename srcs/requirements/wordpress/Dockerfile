FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm tar curl php-mysqli \
    && apt-get clean

COPY wordpress.sh /usr/local/bin/ 

#COPY wp-config.php /var/www/wp-config.php

RUN chmod +x /usr/local/bin/wordpress.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]


