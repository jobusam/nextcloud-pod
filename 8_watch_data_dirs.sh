#!/bin/bash

echo "To watch data dirs of nextcloud and especially of postgres it's necessary to launch a bash within a new usernamespace like in the containers."
echo "Within this usernamespace you are root, but it's a fake root and not the real one of the host system!"
echo "see also https://podman.io/blogs/2018/10/03/podman-remove-content-homedir.html for further information"
buildah unshare
