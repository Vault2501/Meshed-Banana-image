#!/bin/bash

LOG="build.log"

IMAGE=$(grep "Done building" ${LOG} | grep -o -e "Armbian.*\.img")



image_mount() {
    device=$(losetup --show -f -P output/images/$IMAGE)
    for partition in "$device"?*; do
        if [ "$partition" = "${device}p*" ]; then
            partition="${device}"
        fi
        dst="/mnt/$(basename "$partition")"
        mkdir -p "$dst"
        mount "$partition" "$dst"
    done
    sleep 1
    echo $device
}


image_umount() (
  device=$DEVICE
  for partition in $(ls ${device}p*); do
    sudo umount "$partition"
  done
  sudo losetup -d "$device"
)


enable_hdmi() {
    device=$DEVICE
    for partition in $(ls ${device}p*); do
	ls /mnt/$(basename "$partition")
        target="/mnt/$(basename "$partition")/config.txt"
	echo "Checking for ${target} in ${partition}"
        if [ -f $target ]; then  
	    echo "Found ${target}"
	    if grep "hdmi_force_hotplug=1" ${target}; then
	        echo "Already patched"
            else
		echo "Patching"
    	    	sed -i 's/hdmi_drive=2/hdmi_drive=2\nhdmi_force_hotplug=1/' $target
            fi
	fi
    done
}

DEVICE=$(image_mount)
enable_hdmi $DEVICE
#read
image_umount $DEVICE
