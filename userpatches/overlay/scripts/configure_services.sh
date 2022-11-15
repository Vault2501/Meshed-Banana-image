#!/bin/sh

echo "\nRunning ${0}\n"

# add reticulum,dhcpd and dns ports to firewall
firewall-offline-cmd --zone=public --add-port=53/tcp
firewall-offline-cmd --zone=public --add-port=67/tcp
firewall-offline-cmd --zone=public --add-port=80/tcp
firewall-offline-cmd --zone=public --add-port=5900/tcp
firewall-offline-cmd --zone=public --add-port=5901/tcp
firewall-offline-cmd --zone=public --add-port=6001/tcp
firewall-offline-cmd --zone=public --add-port=37428/tcp
firewall-offline-cmd --zone=public --add-port=37429/tcp
firewall-offline-cmd --zone=public --add-port=53/udp
firewall-offline-cmd --zone=public --add-port=67/udp
firewall-offline-cmd --zone=public --add-port=80/udp
firewall-offline-cmd --zone=public --add-port=42671/udp
firewall-offline-cmd --zone=public --add-port=42735/udp
firewall-offline-cmd --zone=public --add-port=29716/udp
firewall-offline-cmd --zone=public --add-masquerade
firewall-offline-cmd --change-zone=wlan0 --zone=public
firewall-offline-cmd --change-zone=uap0 --zone=public


# disable xfce by default
systemctl disable lightdm

# disable dhcp server by default
systemctl disable isc-dhcp-server
systemctl disable isc-dhcp-server6

# disable hostapd by default
systemctl disable hostapd

# enable rnsd
systemctl enable rnsd

# enable rnsd
systemctl enable nomadnet

# enable graphical login
ln -s /lib/systemd/system/lightdm.service /etc/systemd/system/display-manager.service

# enable x11vnc
systemctl enable x11vnc@:0

# disable autologin
rm -f /etc/systemd/system/getty@.service.d/override.conf
rm -f /etc/systemd/system/serial-getty@.service.d/override.conf
