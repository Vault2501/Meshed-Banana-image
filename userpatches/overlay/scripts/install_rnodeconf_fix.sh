#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"
USER=${1:-nomad}

WD=$(pwd)

cd /home/${USER}/.local/lib/python3.10/site-packages/rnodeconf
mv rnodeconf.py rnodeconf.py.orig
wget https://raw.githubusercontent.com/SebastianObi/rnodeconfigutil/master/rnodeconf/rnodeconf.py
cd /home/$USER
/home/${USER}/.local/bin/rnodeconf --download
cd $WD 
