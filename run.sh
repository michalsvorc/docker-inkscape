#!/bin/bash
# Author: Michal Svorc <michal@svorc.sk>
# Run docker container
# Optional argument: Docker tag to run specific tagged image.
# Defaults to most recent tag when not provided.
# Example: ./run.sh X.Y

# Declare base variables
docker_tag_default=0.92
app_name=inkscape
dockerhub_namespace=michalsvorc

# Interpolate additional variables
docker_tag="${1:-$docker_tag_default}"
image_name=$dockerhub_namespace/$app_name:$docker_tag
container_name=$dockerhub_namespace-$app_name-$docker_tag
mount_path="${PWD}/mount"
user_name=$app_name

# Control appliacation permission to make connections to the X server
# Requires system xorg-xhost package
xhost_switch() {
    local switch_value=$1
    local application=$2

    if $switch_value; then
        xhost +local:$application
    else
        xhost -local:$application
    fi
}

# Run
xhost_switch true 'docker' \
&& docker run -it \
    --rm \
    --env DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --mount type=bind,source=$mount_path/workspace,target=/home/$user_name/workspace \
    --name $container_name \
    $image_name \
; xhost_switch false 'docker'
