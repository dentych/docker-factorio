# Factorio Docker image
Factorio docker image based on Alpine

# Usage
## Building image
```
$ make build
```

## Create volume (one time)
```
$ make volume
```

## Run the server
```
$ make run
```

## Stop the server
```
$ make stop
```


# GLIBC version
This image uses GLIBC for running Factorio.

Version: *2.23-r3*

The library apk for alpine used can be found in this repo: https://github.com/sgerrand/alpine-pkg-glibc
