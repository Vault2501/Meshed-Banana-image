#!/bin/sh

echo "\nRunning ${0}\n"

USER=${1:=lora}
SCRIPT_DIR=$(dirname "$0")
CONFIG="${SCRIPT_DIR}/../config_files"

# create copy of user reticulum installation
cp -r /home/${USER} /opt/reticulum_env
chown -R root.users /opt/reticulum_env
chmod og+rx `find /opt/reticulum_env/.local -type d`
chmod og+r `find /opt/reticulum_env/.local -type f`

# remove cache files to save space
rm -rf /opt/reticulum_env/.cache/ /opt/reticulum_env/.cargo/registry/src/

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
