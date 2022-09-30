#!/bin/sh

echo "\nRunning ${0}\n"

# For now just disable the firewall for testing
systemctl mask firewalld

# disable xfce by default
systemctl disable lightdm

# disable dhcp server by default
systemctl disable isc-dhcp-server

# disable hostapd by default
systemctl disable hostapd

# enable rnsd
systemctl enable rnsd
