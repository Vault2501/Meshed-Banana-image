#!/bin/sh

USAGE="${0} <mode>\n\tmode: ap, client"


if [ -z "$1" ]; then
    echo "Please provide a mode"
    echo ${USAGE}
    exit 1
fi

if [ ${1} = "ap" ]; then
    echo "Switching to AP mode"
    # disable NetworkManager
    systemctl mask NetworkManager

    # enable hostapd
    systemctl enable hostapd

    # enable dhcpd
    systemctl enable isc-dhcp-server
    systemctl enable isc-dhcp-server6

    # disable systemd-resolved
    systemctl mask systemd-resolved
    # enable dnsmasq
    systemctl enable dnsmasq

    # enable rnsd
    systemctl enable rnsd

    # disable autologin
    rm -f /etc/systemd/system/getty@.service.d/override.conf
    rm -f /etc/systemd/system/serial-getty@.service.d/override.conf


elif [ ${1} = "client" ]; then
    echo "Switching to client mode"

    # disable systemd-resolved
    systemctl unmask systemd-resolved
    # enable dnsmasq
    systemctl disable dnsmasq

    # enable NetworkManager
    systemctl unmask NetworkManager

    # disable hostapd
    systemctl disable hostapd

    # disable dhcpd
    systemctl disable isc-dhcp-server
    systemctl disable isc-dhcp-server6
else
    echo "Unknown mode."
    echo ${USAGE}
    exit 1
fi

echo "Please reboot for the changes to take effect"
