FROM debian:11

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    && apt-get clean

RUN mkdir -p /var/www/html/

RUN mkdir -p /run/php/

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]
