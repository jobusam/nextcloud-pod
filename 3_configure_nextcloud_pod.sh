#!/bin/bash

source 0_env.sh

echo "Configure Nextcloud Pod"
echo "Wait 10 seconds to allow fresh Nextcloud instance to come up"
sleep 10
echo "Create Admin User (do installation routine in nextcloud)"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ maintenance:install --admin-user=$NEXTCLOUD_ADM_USER --admin-pass=$NEXTCLOUD_ADM_PWD --admin-email=$NEXTCLOUD_ADM_MAIL

echo "Set up Nextcloud to work with NGINX reverse proxy"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ config:system:set trusted_domains 2 --value=$DOMAIN
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ config:system:set overwritehost --value=$DOMAIN:$EXT_PORT
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ config:system:set overwriteprotocol --value=$PROTOCOL

echo "Install recommended apps in nextcloud"

echo "For installing apps fix a bug before (see https://help.nextcloud.com/t/appstore-is-empty/65078)"
echo "Increase timeout from 10 sec to 100 secs in file /var/www/html/lib/private/App/AppStore/Fetcher/Fetcher.php"
podman exec --user www-data seamless-nexcloud /bin/bash -c "
cat /var/www/html/lib/private/App/AppStore/Fetcher/Fetcher.php |
awk '/timeout/{gsub(/10/, '100')};{print}' > /var/www/html/lib/private/App/AppStore/Fetcher/Fetcher.php.tmp &&
mv /var/www/html/lib/private/App/AppStore/Fetcher/Fetcher.php.tmp /var/www/html/lib/private/App/AppStore/Fetcher/Fetcher.php"
echo "Bug was fixed!"
echo "Now installing apps..."

echo "Install contacts"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install contacts

echo "Install calendar"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install calendar

echo "Install mail client"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install mail

echo "Install groupfolders to create folders for specific groups"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install groupfolders

echo "Install talk (spreed)"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install spreed
echo "Next Bugfix. Due to errors in spreed installation spreed must be explicitly enabled"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:enable spreed

echo "Install drawio for creating diagrams"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install drawio

echo "Install onlyoffice for processing office documents"
podman exec --user www-data $NEXTCLOUD_CONTAINER php occ app:install onlyoffice
