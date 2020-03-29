#!/bin/bash

source 0_env.sh

WORK_DIR=$LETSENCRYPT_DIR/work
LOG_DIR=$LETSENCRYPT_DIR/log
CONF_DIR=$LETSENCRYPT_DIR/conf

# only for tests
sudo rm -rf $LETSENCRYPT_DIR

mkdir -p $WORK_DIR
mkdir -p $LOG_DIR
mkdir -p $CONF_DIR

echo "Request Let's encrypt certificate in $LETSENCRYPT_DIR for hostname $DOMAIN"

podman run -it --rm --name certbot -p 80:80 \
-v $CONF_DIR:/etc/letsencrypt:Z \
-v $WORK_DIR:/var/lib/letsencrypt:Z \
-v $LOG_DIR:/var/log/letsencrypt:Z \
certbot/certbot:$LETSENCRYPT_VERSION \
certonly --standalone --preferred-challenges http-01 --agree-tos -m $LETS_ENCRYPT_CONTACT_EMAIL -d $DOMAIN --dry-run
