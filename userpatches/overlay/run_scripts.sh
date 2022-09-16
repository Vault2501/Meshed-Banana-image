#!/bin/sh

echo "Running custom image scripts"


SCRIPT_DIR=$(dirname "$0")
#. ${SCRIPT_DIR}/image.config

SCRIPTS="${SCRIPT_DIR}/scripts"
USER="${DEFAULT_USER:=lora}"
BOARD="${BOARD:=bananapim2zero}"

echo $BOARD

# Add user
${SCRIPTS}/create_user.sh ${USER}

# Install required packages
${SCRIPTS}/install_required_packages.sh

# Install latest rust
sudo -u ${USER} -H ${SCRIPTS}/install_rust.sh

# Install python modules
sudo -u ${USER} -H bash -e ${SCRIPTS}/install_python_modules.sh

# Patch pyserial to recognice /dev/ttyS3
#sudo -u $DEFAULT_USER -H /tmp/overlay/patch_pyserial.sh

# Copy reticulum/nomadnet config
sudo -u ${USER} -H ${SCRIPTS}/install_rns_config.sh ${BOARD}

# Copy the user dir to skel to make it available for new users
${SCRIPTS}/copy_skel.sh ${USER}

# Rmove user again
${SCRIPTS}/remove_user.sh ${USER}

# Add default groups to newly created users
${SCRIPTS}/add_default_groups.sh

# Enable UART on GPIO for Banana Pi zero
if [ "${BOARD}" = "bananapim2zero" ] ; then
        ${SCRIPTS}/install_uart3_overlay.sh
fi

# Install Soundmodem
#/tmp/overlay/install_soundmodem.sh

# Install Signal-server
#/tmp/overlay/install_signal_server.sh

# Install signal server gui
#/tmp/overlay/install_signal_server_gui.sh $DEFAULT_USER

# Install Nexus server
#sudo -u $DEFAULT_USER -H /tmp/overlay/install_nexus.sh 

# Copy direwolf config
#sudo -u $DEFAULT_USER -H cp /tmp/overlay/direwolf.conf /home/$DEFAULT_USER

