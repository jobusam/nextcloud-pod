#!/bin/bash

NGINX_DATA_DIR="$PWD/../data/nginx"

echo "Start separate nginx proxy"

#Separate:
podman run --rm -p 6060:443 \
-v $NGINX_DATA_DIR/conf/nginx.conf:/etc/nginx/nginx.conf:Z \
-v $NGINX_DATA_DIR/certs:/etc/ssl/private:Z \
--name nginx-reverse nginx:1.17.8

# Inspect container layout
#podman run -p 7070:80 --name nginx-reverse nginx:1.17.8
# then execute podman exec -t -i nginx-reverse /bin/bash
