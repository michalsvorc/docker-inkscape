# [Inkscape](https://inkscape.org/) Docker image

- based on Alpine Linux
- executable Docker image
- persistent application settings

## Mount directories

- **config**: store application settings
- **workspace**: share files between the host and containerized app

## Run

Execute `run.sh` script.

## Troubleshooting

### Write access to mounted directories

Mount directories must be writable by group with id `1000`. Execute these commands in project root directory:

```bash
sudo chown -R $(id -u):1000 "${PWD}"/config "${PWD}"/workspace
sudo chmod -R g+w "${PWD}"/config "${PWD}"/workspace
```

