#!/bin/sh
set -eufx

INSTALLER_TYPE=$1
INSTALLATION_TYPE=$2

export INSTALLATION_TYPE
export INSTALLER_TYPE

docker-compose -f /etc/racket-installer/docker-compose.yml -p ${INSTALLER_TYPE} build --force-rm  ${INSTALLATION_TYPE}
docker-compose -f /etc/racket-installer/docker-compose.yml -p ${INSTALLER_TYPE} run --rm ${INSTALLATION_TYPE} racket --version
