FROM alpine:3.19.3

RUN apk add --no-cache nginx

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /usr/share/nginx/html && \
    echo "<html><body><h1>Welcome to Nginx on Alpine!</h1></body></html>" > /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

