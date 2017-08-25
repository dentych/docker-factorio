#!/bin/bash

VERSION=$1
SAVEFOLDER=$2

docker run --name factorio -it -p 34197:34197/udp -v $SAVEFOLDER:/opt/factorio/savegame dentych/factorio:$VERSION
