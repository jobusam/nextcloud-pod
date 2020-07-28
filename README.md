# nextcloud-pod
This repository contains shell scripts to setup a nextcloud instance with podman.
It will start a nextcloud container, a postgres database and a nginx reverse proxy
that uses TLS. All containers are deployed together as pod an therefore share the same
namespace, host, etc.

TODO: How to setup


## Backup
To backup the local data run following command as root user in data directory:
````
$ cp -rp data/ data_backup_08.6.2020
````
