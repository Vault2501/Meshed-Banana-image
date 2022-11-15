#!/bin/sh

echo "\nRunning ${0}\n"

# Reticulum
# REQUIRED_PACKAGES="${REQUIRED_PACKAGES} python3-pip python3-setuptools build-essential python3-dev libffi-dev rustc cargo libssl-dev python3-wheel"
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} libgl1-mesa-dev python3-pip python3-setuptools build-essential python3-dev libffi-dev cargo libssl-dev python3-wheel rust-all python3-setuptools-rust python3-pil python3-pygame"

# Console tools
#REQUIRED_PACKAGES="${REQUIRED_PACKAGES} armbian-config vim screen git iptables firewalld nftables bridge-utils"
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} iw tcpdump armbian-config vim screen git iptables firewalld nftables bridge-utils"

# Services
#REQUIRED_PACKAGES="${REQUIRED_PACKAGES} dnsmasq hostapd isc-dhcp-server"
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} i2pd"

# Desktop
#REQUIRED_PACKAGES="${REQUIRED_PACKAGES} libxkbcommon-x11-0 xsel fonts-roboto arctica-greeter arctica-greeter-theme-debian xfonts-base tightvncserver x11vnc xorg lightdm xfce4 tango-icon-theme gnome-icon-theme dbus-x11"
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} wireshark libxkbcommon-x11-0 xsel fonts-roboto  lightdm-gtk-greeter lightdm-gtk-greeter-settings xfonts-base tightvncserver x11vnc xorg lightdm xfce4 tango-icon-theme gnome-icon-theme dbus-x11"

# Packages to remove
#REMOVE_PACKAGES="rustc libstd-rust-1.59 libstd-rust-dev"

echo "Installing additional packages: ${REQUIRED_PACKAGES}"
apt-get update
apt-get install -y ${REQUIRED_PACKAGES}

#echo "Uninstall rust as it is too outdated"
#apt-get remove -y ${REMOVE_PACKAGES}
