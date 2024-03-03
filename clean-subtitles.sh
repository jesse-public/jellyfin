#!/usr/bin/env bash

docker-compose down
rm -rf volumes/config/data/data/subtitles
docker-compose up -d
