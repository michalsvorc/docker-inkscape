#!/bin/bash
# Author: Michal Svorc <michalsvorc.com>
# Run Docker container with predefined mount directories

# Source Docker arguments
source ./.config

# Docker run
docker run \
    -it \
    --rm \
    --env DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --mount type=bind,source=$mount_config_source,target=$mount_config_target \
    --mount type=bind,source=$mount_workspace_source,target=$mount_workspace_target \
    --name $container_name \
    $image_name:$image_tag
