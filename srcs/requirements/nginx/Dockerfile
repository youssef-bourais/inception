FROM alpine:3.20

RUN apk add --no-cache nginx openssl

COPY nginx.conf /etc/nginx/nginx.conf

COPY ./tools/ssl.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/ssl.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/ssl.sh"]



