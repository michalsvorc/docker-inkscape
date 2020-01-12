#!/bin/bash
# Author: Michal Svorc <michalsvorc.com>
# Run docker container with predefined mount directories

# Declare variables
image_repository='michalsvorc'
image_name='inkscape'
image_tag=$(git describe --tags --abbrev=0)
user_name=$image_name
mount_path="${PWD}"

# Run
docker run \
    -it \
    --rm \
    --env DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --mount type=bind,source=$mount_path/workspace,target=/home/$user_name/workspace \
    --name $image_repository-$image_name-$image_tag \
    $image_repository/$image_name:$image_tag
