#!/bin/bash
set -eufx

declare -A platforms

platforms["linux-32-ospkg"]="i386-linux"
platforms["linux-64-ospkg"]="x86_64-linux"
platforms["linux-64-natipkg"]="x86_64-linux-natipkg"

declare -A dists

dists["full"]="racket"
dists["minimal"]="racket-minimal"

OUTFILE=$1

INSTALLER_FILE_NAME="${dists[$INSTALLER_DIST]}-${RACKET_VERSION}-${platforms[$INSTALLER_PLATFORM]}.${INSTALLER_FILE_EXTENSION}"
INSTALLER_URL="https://mirror.racket-lang.org/installers/${RACKET_VERSION}/${INSTALLER_FILE_NAME}"

wget --quiet -O ${OUTFILE} ${INSTALLER_URL}
