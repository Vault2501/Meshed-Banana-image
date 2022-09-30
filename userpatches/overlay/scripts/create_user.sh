#!/bin/sh

echo "\nRunning ${0}\n"

USER=${1:-rnsd}
GROUPS=${2:-"dialout cdrom floppy audio video plugdev users sudo"}

if $(useradd -m -s /bin/bash ${USER}); then 
    echo "Created user ${USER}"
    sudo -u ${USER} -H echo "PATH=\"\$HOME/.local/bin:${PATH}\"" \
        >> /home/${USER}/.profile

    echo "Adding ${USER} to groups"
    for group in ${GROUPS}; do
        usermod -a -G ${group} ${USER}
    done 

    echo "Setting password for ${USER}"
    echo "${USER}:nomad" | chpasswd

    sudo -u ${USER} -H mkdir -p /home/${USER}/Apps
else
    echo "Could not create user ${USER}"
fi
