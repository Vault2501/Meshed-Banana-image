#!/bin/sh

echo "\nRunning ${0}\n"

SCRIPT_DIR=$(dirname "$0")
BOARD=${1:-bananapim2zero}

echo Board: ${BOARD}

if [ ${BOARD} = "rpi4b" ]; then
    sed -i 's/hdmi_drive=2/hdmi_drive=2\nhdmi_force_hotplug=1/' /boot/firmware/config.txt
fi
