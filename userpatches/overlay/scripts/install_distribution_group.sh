#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"
USER=${1:-nomad}

mkdir -p /home/${USER}/Apps

WD=$(pwd)

cd /home/${USER}/Apps
mkdir lxmf_distribution_group
cd lxmf_distribution_group
wget https://raw.githubusercontent.com/SebastianObi/LXMF-Tools/main/lxmf_distribution_group/lxmf_distribution_group.py
chmod +x lxmf_distribution_group.py
cd $WD 
