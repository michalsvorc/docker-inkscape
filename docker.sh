#!/usr/bin/env bash
# Author: Michal Svorc <michalsvorc.com>
# Description: Docker commands helper script

#===============================================================================
# Script options
#===============================================================================

set -o errexit      # abort on nonzero exitstatus
set -o nounset      # abort on unbound variable
set -o pipefail     # don't hide errors within pipes
# set -o xtrace       # debugging

#===============================================================================
# Variables
#===============================================================================

# Docker arguments
image_name='michalsvorc/inkscape'
image_tag=$(git describe --tags --abbrev=0)

container_name="${image_name//\//_}-${image_tag}"

mount_config_source="${PWD}/config"
mount_config_target="/home/user/.config/inkscape"

mount_workspace_source="${PWD}/workspace"
mount_workspace_target="/home/user/workspace"

#===============================================================================
# Help
#===============================================================================

_print_help() {
cat <<HELP
Usage: ./docker.sh [COMMAND]

Docker commands helper script

Commands:
    -h|--help       print this help text and exit
    build           build Docker image
    run             run Docker image

Example: ./docker.sh run
HELP
}

#===============================================================================
# Functions
#===============================================================================

_die() {
    local error_message="${1}"
    printf 'Error: %s\nSee help for proper usage:\n\n' "${error_message}" >&2
	_print_help
    exit 1
}

_docker_build() {
    printf 'Docker build %s\n' "${image_name}:${image_tag}"

    docker build \
        --build-arg app_version=${image_tag} \
        --tag ${image_name}:${image_tag} \
        .
}

_docker_run() {
    printf 'Docker run %s\n' "${image_name}:${image_tag}"

    docker run \
        -it \
        --rm \
        --env DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        --mount type=bind,source=$mount_config_source,target=$mount_config_target \
        --mount type=bind,source=$mount_workspace_source,target=$mount_workspace_target \
        --name $container_name \
        $image_name:$image_tag
}

#===============================================================================
# Execution
#===============================================================================

if [ $# -eq 0 ]; then
    _die 'No arguments provided'
fi

case "${1}" in
    -h|--help)
        _print_help
        ;;
    build)
        _docker_build
        ;;
    run)
        _docker_run
        ;;
    *)
        _die "Unknown argument '${1}'"
        ;;
esac
