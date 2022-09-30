#!/bin/sh

echo "\nRunning ${0}\n"

# Reticulum
# REQUIRED_PACKAGES="${REQUIRED_PACKAGES} python3-pip python3-setuptools build-essential python3-dev libffi-dev rustc cargo libssl-dev python3-wheel"
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} libgl1-mesa-dev python3-pip python3-setuptools build-essential python3-dev libffi-dev cargo libssl-dev python3-wheel rust-all python3-setuptools-rust python3-pil python3-pygame"

# Console tools
#REQUIRED_PACKAGES="${REQUIRED_PACKAGES} armbian-config vim screen git iptables firewalld nftables bridge-utils"
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} vim screen git iptables firewalld nftables bridge-utils"

# Services
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} dnsmasq hostapd isc-dhcp-server"

# Desktop
#REQUIRED_PACKAGES="${REQUIRED_PACKAGES} xorg lightdm xfce4 tango-icon-theme gnome-icon-theme"

# PAckages to remove
#REMOVE_PACKAGES="rustc libstd-rust-1.59 libstd-rust-dev"

echo "Installing additional packages: ${REQUIRED_PACKAGES}"
apt-get install -y ${REQUIRED_PACKAGES}

#echo "Uninstall rust as it is too outdated"
#apt-get remove -y ${REMOVE_PACKAGES}
