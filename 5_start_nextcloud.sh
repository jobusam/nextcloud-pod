#!/bin/bash

source 0_env.sh

echo "Start pod $POD"
podman pod start $POD

echo "Start pod $DOC_SERVER_POD"
podman pod start $DOC_SERVER_POD
