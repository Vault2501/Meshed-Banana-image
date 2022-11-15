#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"
BOARD=${1:-bananapim2zero}

echo Board: ${BOARD}

mkdir -p /home/${USER}/.reticulum
mkdir -p /home/${USER}/.nomadnetwork/storage/pages

if [ ${BOARD} = "bananapim2zero" ]; then
    cp ${CONFIG}/reticulum.config.bPizero /home/${USER}/.reticulum/config
    cp ${CONFIG}/index.mu.default /home/${USER}/.nomadnetwork/storage/pages/index.mu
else
    cp ${CONFIG}/reticulum.config.default /home/${USER}/.reticulum/config
    cp ${CONFIG}/index.mu_fdn /home/${USER}/.nomadnetwork/storage/pages/index.mu
fi

cp ${CONFIG}/nomadnet.config /home/${USER}/.nomadnetwork/config
