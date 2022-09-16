#!/bin/sh

echo "\nRunning ${0}\n"

USER=${1:=lora}
SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"

cp -r /home/${USER} /opt/reticulum_env
chown -R root.users /opt/reticulum_env
chmod og+rx `find /opt/reticulum_env/.local -type d`
chmod og+r `find /opt/reticulum_env/.local -type f`
rm -rf /opt/reticulum_env/.cache/ /opt/reticulum_env/.cargo/registry/src/
cp ${CONFIG}/profile /etc/skel/.profile
touch /etc/skel/.not_logged_in_yet
