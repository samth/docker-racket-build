#!/bin/sh
set -eufx

INSTALLER_TYPE=$1
INSTALLATION_TYPE=$2

export INSTALLATION_TYPE
export INSTALLER_TYPE

alias installer-compose="docker-compose -f /etc/racket-installer/docker-compose.yml -p ${INSTALLER_TYPE}"

installer-compose build --force-rm  ${INSTALLATION_TYPE}
installer-compose run --rm ${INSTALLATION_TYPE} racket --version
