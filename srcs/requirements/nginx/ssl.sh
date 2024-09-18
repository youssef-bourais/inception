#!/bin/sh


KEY_FILE="/etc/ssl/private/myserver.key"
CSR_FILE="/tmp/myserver.csr" 
CRT_FILE="/etc/ssl/certs/myserver.crt"

mkdir -p /var/www/html/

mkdir -p /etc/ssl/certs /etc/ssl/private

openssl genrsa -out $KEY_FILE 2048

openssl req -new -key $KEY_FILE -out $CSR_FILE \
    -subj "/C=MA/ST=tetouan-martil/L=tetouan/O=matrix/CN=ybourais.42.fr/emailAddress=inception@1337.ma"

openssl x509 -req -days 365 -in $CSR_FILE -signkey $KEY_FILE -out $CRT_FILE

echo "Certificate and key generated: $CRT_FILE, $KEY_FILE"

nginx -g "daemon off;"

