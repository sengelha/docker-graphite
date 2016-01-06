#!/bin/sh

GRAPHITE_CONTAINER_ID=d096ef10077e
CARBON_CONTAINER_ID=60944c5fa6a4

# Start graphite-web
mkdir -p $PWD/volumes/graphite/var/log
docker run -p 80:80 -v $PWD/volumes/carbon/opt/graphite/storage/whisper:/opt/graphite/storage/whisper -v $PWD/volumes/graphite/var/log:/var/log $GRAPHITE_CONTAINER_ID

# Start carbon
#mkdir -p $PWD/volumes/carbon/opt/graphite/storage/whisper
#mkdir -p $PWD/volumes/carbon/var/log
#docker run -p 2003:2003 -v $PWD/volumes/carbon/opt/graphite/storage/whisper:/opt/graphite/storage/whisper -v $PWD/volumes/carbon/var/log:/var/log $CARBON_CONTAINER_ID
