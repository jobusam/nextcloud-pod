#!/bin/bash

source 0_env.sh

echo "Configure Nextcloud Pod"

echo "Install onlyoffice plugin into nextcloud for processing office documents"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install onlyoffice


echo "Setup Only Office on Port 8080"
podman pod create -n $DOC_SERVER_POD -p $EXT_PORT_DOC_SERVER:443
#echo "Setup Only Office on port 80"
# a data dir for only office is not necessary
podman run -d --pod $DOC_SERVER_POD -e JWT_ENABLED='true' -e JWT_SECRET=$JWT_SECRET \
--restart=always --name=only-office onlyoffice/documentserver:$ONLY_OFFICE_VERSION

echo "Start NGINX Reverse Proxy with HTTPS to forward incoming request to port 80"
podman run -d --pod $DOC_SERVER_POD -v $NGINX_DATA_DIR/conf/nginx.conf:/etc/nginx/nginx.conf:Z \
-v $NGINX_DATA_DIR/certs:/etc/ssl/private:Z --name nginx-reverse-only-office nginx:$NGINX_VERSION

DOC_SERVER_URL="https://$DOMAIN:$EXT_PORT_DOC_SERVER/"

echo "Configure document server url in nextcloud to $DOC_SERVER_URL with secret key $JWT_SECRET"
podman exec --user www-data seamless-nextcloud php occ config:app:set onlyoffice DocumentServerUrl --value $DOC_SERVER_URL
podman exec --user www-data seamless-nextcloud php occ config:app:set onlyoffice jwt_secret --value $JWT_SECRET


