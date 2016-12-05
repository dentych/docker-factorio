# Factorio Docker image
Factorio docker image based on Alpine

# Usage
## Building image
```
$ docker build -t dentych/factorio:0.14.21
```

## Running container
```
$ docker run --name factorio -p 34197:34197 -v /srv/factorio/savegame:/opt/factorio/savegame dentych/factorio:0.14.21
```

# GLIBC version
This image uses GLIBC for running Factorio.

Version: *2.23-r3*
