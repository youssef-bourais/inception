#!/bin/bash

KEY_FILE="myserver.key"
CSR_FILE="myserver.csr"
CRT_FILE="myserver.crt"

openssl genrsa -out $KEY_FILE 2048

openssl req -new -key $KEY_FILE -out $CSR_FILE \
    -subj "/C=MA/ST=tetouan-martil/L=tetouan/O=matrix/CN=localhost/emailAddress=inception@1337.ma"

openssl x509 -req -days 365 -in $CSR_FILE -signkey $KEY_FILE -out $CRT_FILE

echo "Certificate and key generated: $CRT_FILE, $KEY_FILE"

