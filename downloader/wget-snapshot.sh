#!/bin/bash
set -eufx

declare -A platforms

platforms["linux-32-ospkg"]="i386-linux-precise"
platforms["linux-64-ospkg"]="x86_64-linux-precise"
platforms["linux-64-natipkg"]="x86_64-linux-natipkg-precise"

declare -A dists

dists["full"]="racket"
dists["minimal"]="min-racket"

OUTFILE=$1

INSTALLER_FILE_NAME="${dists[$INSTALLER_DIST]}-current-${platforms[$INSTALLER_PLATFORM]}.${INSTALLER_FILE_EXTENSION}"
INSTALLER_URL="https://www.cs.utah.edu/plt/snapshots/current/installers/${INSTALLER_FILE_NAME}"

wget --quiet -O ${OUTFILE} ${INSTALLER_URL}
