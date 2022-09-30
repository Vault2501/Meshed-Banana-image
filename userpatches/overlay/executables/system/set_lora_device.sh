#!/bin/sh

USAGE="${0} <port>\n\tport: e.g. ttyACM0 or ttyUSB0"

if [ -z ${1} ]; then
    echo "No port provided"
    echo $USAGE
    exit 1
fi

sed -i.bak "/^  \[\[RNode LoRa Interface/,/^  \[\[/{s/^.* port = \/dev\/.*/    port = \/dev\/$0/}" ~/.reticulum/config
