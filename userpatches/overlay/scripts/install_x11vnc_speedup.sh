#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"
EXEC="${SCRIPT_DIR}/../executables"
BOARD=${1:-bananapim2zero}

echo Board: ${BOARD}

mkdir -p /home/${USER}/.config/autostart
cp ${CONFIG}/x11vnc-speedup.desktop /home/${USER}/.config/autostart
cp ${EXEC}/x11vnc_speedup.sh /home/${USER}/.local/bin
chmod 755 /home/${USER}/.local/bin/x11vnc_speedup.sh
