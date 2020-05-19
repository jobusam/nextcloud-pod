#!/bin/bash

source 0_env.sh

echo "Stop pod $POD"
podman pod stop $POD

echo "Stop pod $DOC_SERVER_POD"
podman pod stop $DOC_SERVER_POD

