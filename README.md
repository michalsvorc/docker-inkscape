# [Inkscape](https://inkscape.org/) Docker image
- based on Alpine Linux
- executable Docker container
- persistent application settings

## Pull
```bash
docker pull michalsvorc/inkscape:<docker_tag>
```
[List of Docker tags](https://hub.docker.com/repository/docker/michalsvorc/inkscape/tags)

## Prerequisites

### Mount directories
Mount directories must pre-exist on host system and should be writable by group with id `1000`.
- **config**: store application settings
- **workspace**: share images between host and containerized app

Execute in project root directory:
```bash
mkdir -p "${PWD}"/config "${PWD}"/workspace \
&& chown -R $(id -u):1000 "${PWD}"/config "${PWD}"/workspace \
&& chmod -R g+w "${PWD}"/config "${PWD}"/workspace
```

### Run 
Execute `run.sh` script.