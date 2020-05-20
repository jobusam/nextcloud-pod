#!/bin/bash

source 0_env.sh

echo "Create a pod called $POD and open external port $EXT_PORT for nextcloud with https"

# only export https port of reverse proxy (port 443 is also configured in nginx.conf)
podman pod create -n $POD -p $EXT_PORT:443 --add-host=$DOMAIN:$LOCAL_IP_OF_EXTERNAL_IF

echo "Start Postgres and backup data on $POSTGRES_DATA_DIR"
podman run -d --pod $POD -v $POSTGRES_DATA_DIR:/var/lib/postgresql/data:Z \
-e POSTGRES_USER=$DB_USER -e POSTGRES_PASSWORD=$DB_USER_PWD \
--name postgres postgres:$POSTGRES_VERSION

echo "Start Nextcloud on internal port 80 and backup data on $NEXTCLOUD_DATA_DIR"
# using "localhost" as POSTGRES_HOST works because both container are contained
# by the same pod and therefore share the same hostname, mac, etc...
podman run -d --pod $POD -v $NEXTCLOUD_DATA_DIR:/var/www/html:Z \
-e POSTGRES_HOST=localhost -e POSTGRES_USER=$DB_USER -e POSTGRES_PASSWORD=$USER_PWD -e POSTGRES_DB=$DB_NAME \
--name $NEXTCLOUD_CONTAINER nextcloud:$NEXTCLOUD_VERSION

echo "Start NGINX Reverse Proxy with HTTPS to forward incoming request to port 80"
podman run -d --pod $POD -v $NGINX_DATA_DIR/conf/nginx.conf:/etc/nginx/nginx.conf:Z \
-v $NGINX_DATA_DIR/certs:/etc/ssl/private:Z --name nginx-reverse-nextcloud nginx:$NGINX_VERSION
