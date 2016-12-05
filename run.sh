#!/bin/bash

SAVEFOLDER=$1

docker run --name factorio -p 34197:34197 -v $SAVEFOLDER:/opt/factorio/savegame dentych/factorio:0.14.21
