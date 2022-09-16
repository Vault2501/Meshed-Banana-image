#!/bin/sh

echo "\nRunning ${0}\n"

# Reticulum
# REQUIRED_PACKAGES="${REQUIRED_PACKAGES} python3-pip python3-setuptools build-essential python3-dev libffi-dev rustc cargo libssl-dev python3-wheel"
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} python3-pip python3-setuptools build-essential python3-dev libffi-dev cargo libssl-dev python3-wheel"

# Console tools
REQUIRED_PACKAGES="${REQUIRED_PACKAGES} vim screen git"

echo "Installing additional packages: ${REQUIRED_PACKAGES}"
apt-get install -y ${REQUIRED_PACKAGES}

echo "Uninstall rust as it is too outdated"
apt-get remove -y rustc
