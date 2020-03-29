#!/bin/bash

source 0_env.sh

echo "Stop pod $POD"
podman pod stop $POD
