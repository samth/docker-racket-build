#!/bin/sh
set -eufx

RACKET_IMAGE=$1
RACKET_TEST_SUITE=$2
export RACKET_IMAGE

alias test-runner-compose="docker-compose -f /etc/racket-test-runner/docker-compose.yml -p ${RACKET_IMAGE}"

test-runner-compose build --force-rm racket-tests
test-runner-compose run --rm racket-tests suite-${RACKET_TEST_SUITE}
