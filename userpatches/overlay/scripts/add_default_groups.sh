#!/bin/sh


echo "EXTRA_GROUPS=\"dialout cdrom floppy audio video plugdev users sudo\"" >> /etc/adduser.conf
echo "ADD_EXTRA_GROUPS=1" >> /etc/adduser.conf
