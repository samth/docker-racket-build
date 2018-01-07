#!/bin/sh
set -eufx

DOWNLOAD_SOURCE=$1
DOWNLOAD_PLATFORM=$2
DOWNLOAD_DIST=$3
DOWNLOAD_FILE_EXTENSION=$4

export DOWNLOAD_SOURCE
export DOWNLOAD_PLATFORM
export DOWNLOAD_DIST
export DOWNLOAD_FILE_EXTENSION

alias downloader-compose="docker-compose -f /etc/racket-downloader/docker-compose.yml"

downloader-compose build --force-rm download
