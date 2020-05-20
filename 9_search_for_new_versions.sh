#!/bin/bash

source 0_env.sh


echo "Current used Versions:"
echo "Nextcloud: $NEXTCLOUD_VERSION"
echo "POSTGRES: $POSTGRES_VERSION"
echo "NGINX: $NGINX_VERSION"
echo "Only Office: $ONLY_OFFICE_VERSION"
echo "Letsencrypt Certbot: $LETSENCRYPT_VERSION"

echo -e "\n\n Check print version of latest tag:"
echo "Nextcloud: "
skopeo inspect docker://docker.io/library/nextcloud:latest | grep -i VERSION

echo -e "\n Postgres: "
skopeo inspect docker://docker.io/library/postgres:latest | grep -i VERSION

echo -e "\n NGINX: "
skopeo inspect docker://docker.io/library/nginx:latest | grep -i VERSION

echo -e "\n Only Office: "
skopeo inspect docker://docker.io/onlyoffice/documentserver:latest | grep -i VERSION

echo -e "\n Letsencrypt Certbot: "
skopeo inspect docker://docker.io/certbot/certbot:latest | grep -i VERSION

