#!/bin/bash
# Author: Michal Svorc <michalsvorc.com>
# Run Docker container with predefined mount directories

# Docker arguments
image_name='michalsvorc/inkscape'
image_tag=$(git describe --tags --abbrev=0)
container_name="${image_name//\//-}-${image_tag}"
mount_config_dir_source="${PWD}/config"
mount_config_dir_target="/home/user/.config/inkscape"
mount_workspace_dir_source="${PWD}/workspace"
mount_workspace_dir_target="/home/user/workspace"

# Docker run
docker run \
    -it \
    --rm \
    --env DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --mount type=bind,source=$mount_workspace_dir_source,target=$mount_workspace_dir_target \
    --mount type=bind,source=$mount_config_dir_source,target=$mount_config_dir_target \
    --name $container_name \
    $image_name:$image_tag
