#!/bin/sh

echo "\nRunning ${0}\n"

USER=${1:=lora}

if $(useradd -m -s /bin/bash $USER); then 
    echo "Created user ${USER}"
    sudo -u $USER -H echo "PATH=\"\$HOME/.local/bin:${PATH}\"" \
        >> /home/$USER/.profile

    sudo -u $USER -H mkdir -p /home/$USER/Apps
else
    echo "Could not create user ${USER}"
fi
