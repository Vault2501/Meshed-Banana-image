#!/bin/sh

echo "Running custom image scripts"


SCRIPT_DIR=$(dirname "$0")
. ${SCRIPT_DIR}/image.config

SCRIPTS="${SCRIPT_DIR}/scripts"
USER="${DEFAULT_USER:=nomad}"
BOARD="${BOARD:=bananapim2zero}"

echo BOARD: $BOARD
echo USER: $USER

# temporarily disable ipv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

# set hostname to avoid warnings
hostname ubuntu
echo "127.0.0.1 ubuntu" >> /etc/hosts

# Add user
${SCRIPTS}/create_user.sh ${USER}

# Install required packages
${SCRIPTS}/install_required_packages.sh

# Install latest rust
#sudo -u ${USER} -H ${SCRIPTS}/install_rust.sh

# Install python modules
sudo -u ${USER} -H bash -e ${SCRIPTS}/install_python_modules.sh

# Patch pyserial to recognice /dev/ttyS3
#sudo -u $DEFAULT_USER -H /tmp/overlay/patch_pyserial.sh

# Copy reticulum/nomadnet config
sudo -u ${USER} -H ${SCRIPTS}/install_rns_config.sh ${BOARD}

# Install lxmf distributuin group config
sudo -u ${USER} -H ${SCRIPTS}/install_distribution_group.sh ${USER}

# Install nexus
sudo -u ${USER} -H ${SCRIPTS}/install_nexus.sh ${USER}

# Install rnodeconf offline flash fix 
#sudo -u ${USER} -H ${SCRIPTS}/install_rnodeconf_fix.sh ${USER}

# Install upspack_v3
sudo -u ${USER} -H ${SCRIPTS}/install_upspack.sh ${USER}

# Copy media files 
sudo -u ${USER} -H ${SCRIPTS}/install_media.sh ${USER}

# Copy desktop config 
sudo -u ${USER} -H ${SCRIPTS}/install_desktop_config.sh ${USER}

# Copy x11 autostartup script, disabling composite
sudo -u ${USER} -H ${SCRIPTS}/install_x11vnc_speedup.sh

# Copy the user dir to skel to make it available for new users
#${SCRIPTS}/copy_skel.sh ${USER}

# Remove user again
#${SCRIPTS}/remove_user.sh ${USER}

# Add default groups to newly created users
${SCRIPTS}/add_default_groups.sh

# Copy system wide executables
${SCRIPTS}/copy_exectables.sh

# Enable UART on GPIO for Banana Pi zero
if [ "${BOARD}" = "bananapim2zero" ] ; then
        ${SCRIPTS}/install_uart3_overlay.sh
fi

# Set root password
${SCRIPTS}/set_passwords.sh

# Install raspap
${SCRIPTS}/install_raspap.sh

# Copy system wide configs
${SCRIPTS}/copy_system_config.sh ${USER}

# Configure services 
${SCRIPTS}/configure_services.sh

# Enable AP mode by default
#${SCRIPTS}/../executables/system/wifi_mode.sh ap

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

