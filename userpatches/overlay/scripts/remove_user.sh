#!/bin/sh

echo "\nRunning ${0}\n"

USER=${1:-rnsd}

userdel -r ${USER}

