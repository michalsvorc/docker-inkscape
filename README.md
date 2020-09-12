# [Inkscape](https://inkscape.org/) Docker image

- based on Alpine Linux
- executable Docker image
- persistent application settings in mounted directories
- edge APK repository

## Start

Use `docker.sh` script in project directory.

1. Build Docker image: execute `./docker.sh build`.

2. Run Docker image: execute `./docker.sh run`.

Docker container is not removed after exiting the application. To start the container again, execute `./docker.sh start`.

## Mount directories

- **config**: store application settings
- **workspace**: share files between the host and containerized app

## Troubleshooting

### Write access to mounted directories

Mount directories must be writable by group with id `1000`. Execute these commands in project root directory:

```bash
sudo chown -R $(id -u):1000 "${PWD}"/config "${PWD}"/workspace
sudo chmod -R g+w "${PWD}"/config "${PWD}"/workspace
```
