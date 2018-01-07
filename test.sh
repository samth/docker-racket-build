#!/bin/sh
set -eufx

docker-compose build docker-compose
docker-compose build
docker-compose run downloader release linux-64-ospkg full sh
docker-compose run installer linux-64-ospkg-full script-unixstyle
docker-compose run test-runner racket-linux-64-ospkg-full-script-unixstyle nogui
