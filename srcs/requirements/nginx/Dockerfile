FROM alpine:3.20.3

RUN apk add --no-cache nginx openssl

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html/

COPY ssl.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/ssl.sh

ENTRYPOINT ["/usr/local/bin/ssl.sh"]

EXPOSE 443


