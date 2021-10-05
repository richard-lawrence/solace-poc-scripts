#!/bin/sh
# Create Private Key 
openssl genrsa -des3 -out private.key 4096
# Create Server Certificate, change CN for your server name
openssl req -new -x509 -days 1000 -key private.key -out server.crt -subj "/C=IN/ST=KA/L=BLR/O=TECHCOE/CN=localhost"
#openssl req -new -x509 -days 1000 -key private.key -out server.crt -subj "/C=IN/ST=KA/L=BLR/O=TECHCOE/CN=solace.com"
#   Create pem file by concatenating private.key and server.crt
cat private.key > server_cert.pem
cat server.crt >> server_cert.pem

# Copy to /etc/ssl/certs this enables use of curl against local broker
#sudo cp server.crt  /etc/ssl/certs

