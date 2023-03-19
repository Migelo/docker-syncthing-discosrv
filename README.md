# Syncthing discosrv Docker Image

[![Docker Stars](https://img.shields.io/docker/stars/migel0/syncthing-discosrv.svg)](https://hub.docker.com/r/migel0/syncthing-discosrv/)
[![Docker Pulls](https://img.shields.io/docker/pulls/migel0/syncthing-discosrv.svg)](https://hub.docker.com/r/migel0/syncthing-discosrv/)

## Overview

Syncthing relies on a discovery server to find peers on the internet. Anyone can run a discovery server and point Syncthing installations to it. The Syncthing project also maintains a global cluster for public use.

## Upstream Links

- Docker Registry @ [migel0/syncthing-discosrv](https://hub.docker.com/repository/docker/migel0/syncthing-discosrv//)
- GitHub @ [migelo/docker-syncthing-discosrv](https://github.com/Migelo/docker-syncthing-discosrv)

## Quick Start

Just run:

```bash
docker run --rm -p 8443:8443 -p 19200:19200 migel0/syncthing-discosrv
```


## Persistent keys, certs, and db

When using the commands above, docker will remove the old container once it's no longer running. 

```bash
docker volume create syncthing-discosrv
```

Then run the container mapping the `/discosrv` directory into the volume:

```bash
docker run -p 22067:22067 -p 22070:22070 --mount source=syncthing-discosrv,target=/discosrv -d migel0/syncthing-discosrv
```

## Automatically restarting the container on reboot

To automatically restart the container after a host reboot, replace the `--rm` option in any of the docker invocations above with `--restart=always`. This is a simple solution for those who want to have a discosrv server that survives host restarts but prefer not to deal with systemd.
