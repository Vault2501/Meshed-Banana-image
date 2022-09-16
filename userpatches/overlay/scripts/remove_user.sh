#!/bin/sh

echo "\nRunning ${0}\n"

USER=${1:-lora}

userdel -r ${USER}

