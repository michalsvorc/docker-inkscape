# [Inkscape](https://inkscape.org/) Docker image
- based on Alpine Linux
- executable Docker container

## Pull
```bash
docker pull michalsvorc/inkscape:<DOCKER_TAG>
```
For list of available DOCKER_TAGs see [Docker Hub repository](https://hub.docker.com/repository/docker/michalsvorc/inkscape/tags).

## Run
```bash
docker run -it \
    --rm \
    --env DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --mount type=bind,source=<local_workspace>,target=<container_workspace> \
    --mount type=bind,source=<local_profile>,target=<container_profile> \
    --name michalsvorc-inkscape-rm \
    michalsvorc/inkscape:<DOCKER_TAG>
```

### Bind mounts
Optional mount directories to for communication between local machine and Docker container.
- **workspace**: import local files to Inkscape and save Inkscape outputs.

## Run helper script
Execute `./run.sh` helper script to use predefined bind mounts (requires [Xhost](https://jlk.fjfi.cvut.cz/arch/manpages/man/xhost.1)).

Provide Docker tag as an optional argument to run specific tagged image. Defaults to most recent tag when not provided.

Example:
```bash
./run.sh X.Y
```