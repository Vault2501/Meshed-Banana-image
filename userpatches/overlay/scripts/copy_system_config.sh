#!/bin/sh

USER=${1:-rnsd}

echo "\nRunning ${0}\n"

NUMBER=$(cat /dev/urandom | tr -dc 'a-fA-F0-9' | fold -w 4 | head -n 1)

for file in $(ls /tmp/overlay/config_files/system/); do
    target=$(echo ${file} | sed "s/__/\//g")

    echo "Installing ${target}"
    cp "/tmp/overlay/config_files/system/${file}" "${target}"

    echo Setting random number
    sed -i "s/__NUMBER__/${NUMBER}/" "${target}"

    echo Setting user
    sed -i "s/__USER__/${USER}/" "${target}"
done
