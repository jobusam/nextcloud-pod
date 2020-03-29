#!/bin/bash

CERT_DIR=$PWD/../data/certificates
mkdir -p $CERT_DIR
cd $CERT_DIR
CERT_HOST=localhost

echo "Generate self signed certificate in $CERT_DIR for hostname $CERT_HOST"

openssl genrsa -out $CERT_HOST.key 4096
openssl req -new -key $CERT_HOST.key -out $CERT_HOST.csr -subj "/CN=$CERT_HOST"
openssl x509 -req -days 365 -in $CERT_HOST.csr -signkey $CERT_HOST.key -out $CERT_HOST.crt
