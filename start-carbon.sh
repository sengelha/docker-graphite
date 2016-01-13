#!/bin/sh

CARBON_DOCKER_TAG=sengelha/carbon:0.9.15.0

# Start carbon
mkdir -p $PWD/volumes/carbon/opt/graphite/storage/whisper
mkdir -p $PWD/volumes/carbon/var/log
docker run -p 2003:2003 -v $PWD/volumes/carbon/opt/graphite/storage/whisper:/opt/graphite/storage/whisper -v $PWD/volumes/carbon/var/log:/var/log $CARBON_DOCKER_TAG
