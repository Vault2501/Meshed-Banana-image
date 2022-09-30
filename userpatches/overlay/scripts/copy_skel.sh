#!/bin/sh
set -x

echo "\nRunning ${0}\n"

USER=${1:-rnsd}
SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"

# clean up installation
rm -rf ${USER}/.local/share/kivy-examples \
       ${USER}/.cache/ \
       ${USER}/.cargo/registry/src/

# prepare target dir
rm -rf /opt/reticulum_env
mkdir /opt/reticulum_env

# create copy of user reticulum installation
cp -r "/home/${USER}/.cargo" \
      "/home/${USER}/.kivy" \
      "/home/${USER}/.local" \
      "/home/${USER}/.nomadnetwork" \
      "/home/${USER}/.reticulum" \
      "/home/${USER}/.profile" \
    /opt/reticulum_env

# only for non package rust installation (debian)
cp -r "/home/${USER}/.rustup" /opt/reticulum_env 

chown -R root.users /opt/reticulum_env
find /opt/reticulum_env/.local -type d -exec chmod og+rx {} +
find /opt/reticulum_env/.local -type f -exec chmod og+r {} +

# add section to default .profile to copy env on first login
cat >> /etc/skel/.profile <<EOF
if [ -e \$HOME/.not_logged_in_yet ]; then
    echo Copying reticulum environment
    cp -r /opt/reticulum_env/. \$HOME
    rm \$HOME/.not_logged_in_yet
fi
EOF

# touch file to trigger env copy section on first login
touch /etc/skel/.not_logged_in_yet
