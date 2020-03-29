#!/bin/bash

source 0_env.sh

echo "Start pod $POD"
podman pod start $POD
