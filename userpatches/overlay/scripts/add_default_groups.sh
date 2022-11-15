#!/bin/sh

echo "\nRunning ${0}\n"

GROUPS=${1:-"tty dialout cdrom floppy audio video plugdev users sudo"}

echo "EXTRA_GROUPS=\"${GROUPS}\"" >> /etc/adduser.conf
echo "ADD_EXTRA_GROUPS=1" >> /etc/adduser.conf
