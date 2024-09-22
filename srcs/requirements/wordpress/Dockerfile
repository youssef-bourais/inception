FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php-fpm tar curl php-mysqli \
    && apt-get clean

COPY ./tools/wordpress.sh /usr/local/bin/ 

RUN chmod +x /usr/local/bin/wordpress.sh

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]


