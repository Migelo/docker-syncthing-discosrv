# Syncthing discosrv Docker Image

[![Docker Stars](https://img.shields.io/docker/stars/migel0/syncthing-discosrv.svg)](https://hub.docker.com/r/migel0/syncthing-discosrv/)
[![Docker Pulls](https://img.shields.io/docker/pulls/migel0/syncthing-discosrv.svg)](https://hub.docker.com/r/migel0/syncthing-discosrv/)

## Overview

Syncthing discosrv to help Syncthing clients discosrv data when they can't communicate directly due to things like NAT routers and firewalls blocking inbound TCP connections.


## Upstream Links

- Docker Registry @ [migel0/syncthing-discosrv](https://hub.docker.com/repository/docker/migel0/syncthing-discosrv//)
- GitHub @ [migelo/docker-syncthing-discosrv](https://github.com/Migelo/docker-syncthing-discosrv)

## Quick Start

Just run:

```bash
docker run --rm -p 8443:8443 -p 19200:19200 migel0/syncthing-discosrv
```


## Private discosrvs and persistent keys

When using the commands above, docker will remove the old container once it's no longer running. This is fine for public discosrvs where the key does not matter, but becomes impractical for private discosrvs where the URL must contain the key signature.

For those using private discosrvs, it may be a good idea to use persistent storage for the certificate. To that effect, the first step is to create a volume with the command below (only needs to be done once):

```bash
docker volume create syncthing-discosrv
```

Then run the container mapping the `/discosrvsrv` directory into the volume:

```bash
docker run -p 22067:22067 -p 22070:22070 --mount source=syncthing-discosrv,target=/discosrv -d migel0/syncthing-discosrv```

## Automatically restarting the container on reboot

To automatically restart the container after a host reboot, replace the `--rm` option in any of the docker invocations above with `--restart=always`. This is a simple solution for those who want to have a discosrv server that survives host restarts but prefer not to deal with systemd.

