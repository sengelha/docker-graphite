#!/bin/sh

GRAPHITE_DOCKER_TAG=sengelha/graphite:0.9.15.0

# Start graphite-web
mkdir -p $PWD/volumes/graphite/var/log
mkdir -p $PWD/volumes/graphite/var/log/nginx
docker run -p 80:80 -v $PWD/volumes/carbon/opt/graphite/storage/whisper:/opt/graphite/storage/whisper -v $PWD/volumes/graphite/var/log:/var/log $GRAPHITE_DOCKER_TAG
