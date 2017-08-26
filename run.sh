#!/bin/bash

docker run --name factorio -it --rm \
    -p 34197:34197/udp \
    -v $(pwd)/saves:/opt/factorio/saves \
    -v $(pwd)/server-settings.json:/opt/factorio/server-settings.json \
    dentych/factorio:0.15.33 \
    $@
