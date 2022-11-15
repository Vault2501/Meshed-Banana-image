#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"
USER=${1:-nomad}

mkdir -p /home/${USER}/Apps

WD=$(pwd)

cd /home/${USER}/Apps
git clone https://github.com/rcdrones/UPSPACK_V3.git 
cd $WD 
