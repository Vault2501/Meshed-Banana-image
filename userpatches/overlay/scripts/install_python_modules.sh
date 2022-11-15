#!/bin/sh

echo "\nRunning ${0}\n"

PYTHON_MODULES="cryptography rns lxmf nomadnet requests sbapp RPi.GPIO "

echo "Installing python modules: ${PYTHON_MODULES}"
#pip3 install --upgrade pip
#source "$HOME/.cargo/env"
#rustup default stable
pip3 install ${PYTHON_MODULES}
