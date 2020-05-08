#!/bin/bash

# This script contains alle requried environment parameters
# Please overwrite following values and credentials and mail accounts!

# External Domain (under the server is reachable from the clients)
DOMAIN=seamless.ddns.net
# on local deployment use port higher than 1024 otherwise you neeed root privileges
EXT_PORT=9090

# administrator credentials for nextcloud
# TODO: OVERWRITE these values!!!
NEXTCLOUD_ADM_USER=test-admin-4
NEXTCLOUD_ADM_PWD=randomPassword223
NEXTCLOUD_ADM_MAIL=test-admin-4@random-xyz.com

# registered at let's encrypt. This mail address will be registered during creation of let's encrypt certificate.
LETS_ENCRYPT_CONTACT_EMAIL=test-admin-4@random-xyz.com

# for postgres database set user and password
DB_USER=nextcloud
# TODO: Change me
DB_USER_PWD=mysecretpassword-1238ds!
DB_NAME=nextcloud

# for local deployment use data dir in current folder of the scripts
base_dir_of_script=$(realpath $(dirname $0))
BASE_DIR=$base_dir_of_script/data

# TODO: Overwrite BASE_DIR if the nextcloud data should be located somewhere else!
# BASE_DIR=???

#-------------------------------------------------------------------------------
# Following environment parameters can be changed but it's not necessary

#oci image versions:
NEXTCLOUD_VERSION=18.0.3
POSTGRES_VERSION=12.2-alpine
NGINX_VERSION=1.17.9-alpine
ONLY_OFFICE_VERSION=5.5.1.76
LETSENCRYPT_VERSION=v1.2.0

# name of the pod
POD=nextpod
# name of the nextcloud-container
NEXTCLOUD_CONTAINER=seamless-nexcloud
# use HTTPS. The value is set in Nextcloud config
# Keep in mind:you also have to change the nginx.conf if you don't use TLS
PROTOCOL=https

# set Java Web Token for OnlyOffice. This password must be later set in Nextcloud configuration
# to connect securly to OnlyOffice:
JWT_SECRET=jwt23801-tia

# Data directories for the services
NEXTCLOUD_DATA_DIR="$BASE_DIR/nextcloud"
POSTGRES_DATA_DIR="$BASE_DIR/postgres"
NGINX_DATA_DIR="$BASE_DIR/nginx"
LETSENCRYPT_DIR="$BASE_DIR/letsencrypt"
