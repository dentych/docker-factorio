# Factorio Docker image
Factorio docker image based on Alpine

# Usage
## Building image
```
$ docker build -t dentych/factorio:0.14.21
```
or run the `build.sh` script.

## Running container
```
$ docker run --name factorio -p 34197:34197/udp -v /srv/factorio/savegame:/opt/factorio/savegame dentych/factorio:0.14.21
```
or run the `run.sh` script. Takes one parameter, which is the host directory name of the savegame (OR a volume name).

# GLIBC version
This image uses GLIBC for running Factorio.

Version: *2.23-r3*

The library apk for alpine used can be found in this repo: https://github.com/sgerrand/alpine-pkg-glibc
