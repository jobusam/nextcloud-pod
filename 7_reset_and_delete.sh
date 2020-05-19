#!/bin/bash

source 0_env.sh

echo "The script will remove the pod and all containers."
echo "ADDITIONALLY it will DELETE the nextcloud DATA and postgres database!!!"
echo "You can't restore user data afterwards!"
read -p "Are you sure? [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo "Stop pods and delete containers"
podman pod rm -f $POD
podman pod rm -f $DOC_SERVER_POD


echo "Delete data dirs by changing into container namespace with buildah unshare"
# otherwise it's not possible to delete the data without root, see https://podman.io/blogs/2018/10/03/podman-remove-content-homedir.html
buildah unshare rm -r $NEXTCLOUD_DATA_DIR
buildah unshare rm -r $POSTGRES_DATA_DIR
mkdir $NEXTCLOUD_DATA_DIR
mkdir $POSTGRES_DATA_DIR
