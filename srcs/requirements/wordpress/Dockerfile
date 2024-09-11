FROM debian:unstable-20240904-slim

RUN apt-get update && apt-get install -y \
    php-fpm tar curl php-mysqli \
    && apt-get clean

#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#    && chmod +x wp-cli.phar \
#    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html/
RUN mkdir -p /run/php/

RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf

COPY wordpress.sh /usr/local/bin/ 

RUN chmod +x /usr/local/bin/wordpress.sh

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]

EXPOSE 9000

#CMD ["php-fpm7.4", "-F"]
