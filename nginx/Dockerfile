FROM alpine:3.19.3

RUN apk add --no-cache nginx

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html/

COPY myserver.crt /etc/ssl/certs/myserver.crt

COPY myserver.key /etc/ssl/private/myserver.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
