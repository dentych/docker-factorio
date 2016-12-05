#!/bin/bash

SAVEFOLDER=$1

docker run --name factorio -it -p 34197:34197/udp -v $SAVEFOLDER:/opt/factorio/savegame dentych/factorio:0.14.21
