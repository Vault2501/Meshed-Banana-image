#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
MEDIA="${SCRIPT_DIR}/../media"
USER=${1:-nomad}

mkdir /home/${USER}/backgrounds
cp ${MEDIA}/* /home/${USER}/backgrounds
