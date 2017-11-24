#!/bin/sh
set -eufx

RACKET_IMAGE=$1
export RACKET_IMAGE

docker-compose -f /etc/racket-test-runner/docker-compose.yml -p ${RACKET_IMAGE} build --force-rm test-base
docker-compose -f /etc/racket-test-runner/docker-compose.yml -p ${RACKET_IMAGE} run --rm test-nogui
docker-compose -f /etc/racket-test-runner/docker-compose.yml -p ${RACKET_IMAGE} run --rm test-gui
