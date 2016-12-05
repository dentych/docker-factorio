#!/bin/bash

VERSION=$1

docker build -t dentych/factorio:$VERSION .
