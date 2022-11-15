#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"
USER=${1:-nomad}

mkdir -p /home/${USER}/.config/xfce4/xfconf/xfce-perchannel-xml/
mkdir -p /home/${USER}/Desktop

cp ${CONFIG}/xfce4-desktop.xml /home/${USER}/.config/xfce4/xfconf/xfce-perchannel-xml/
cp ${CONFIG}/Sideband.desktop /home/${USER}/Desktop
