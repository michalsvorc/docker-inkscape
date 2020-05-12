#!/bin/bash
# Author: Michal Svorc <michalsvorc.com>
# Build Docker image

# Source Docker arguments
source ./.config

# Docker build
docker build \
    --build-arg app_version=${image_tag} \
    --tag ${image_name}:${image_tag} \
    .
