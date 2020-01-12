# [Inkscape](https://inkscape.org/) Docker image
- based on Alpine Linux
- executable Docker container

## Pull
```bash
docker pull michalsvorc/gimp:<docker_tag>
```
[List of Docker tags](https://hub.docker.com/repository/docker/michalsvorc/inkscape/tags)

## Run
```bash
docker run -it \
    --rm \
    --env DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --mount type=bind,source=<host_workspace>,target=<container_workspace> \
    --name michalsvorc-inkscape \
    michalsvorc/inkscape:<docker_tag>
```

### Mount directories
- **workspace**: share images between host and containerized app

### Run helper script
Execute `./run.sh` helper script to use project repository mount directories.

## FAQ

### ERROR: unable to open for writing: [Errno 13] Permission denied
Mount directories should pre-exist on host system and should be writable by group with gid `1000`.

Make directory writable by gid `1000`:
```bash
chown -R $(id -u):1000 <directory>
chmod -R g+w <directory>