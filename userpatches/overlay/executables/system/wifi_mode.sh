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

    # enable dnsmasq
    systemctl enable dnsmasq

    # enable rnsd
    systemctl enable rnsd

    # open port in firewall
    # firewall-cmd --zone=public --add-port=37428/tcp
    # firewall-cmd --zone=public --add-port=37429/tcp

    # disable firewall for testing purposes
    systemctl mask firewalld

    # disable systemd-resolved
    systemctl mask systemd-resolved
elif [ ${1} = "client" ]; then
    echo "Switching to client mode"

    # enable firewall
    systemctl unmask firewalld

    # disable systemd-resolved
    systemctl unmask systemd-resolved

    # enable NetworkManager
    systemctl unmask NetworkManager

    # disable rnsd
    systemctl disable rnsd

    # disable hostapd
    systemctl disable hostapd

    # disable dhcpd
    systemctl disable isc-dhcp-server

    # enable dnsmasq
    systemctl disable dnsmasq
else
    echo "Unknown mode."
    echo ${USAGE}
    exit 1
fi

echo "Please reboot for the changes to take effect"
