#!/bin/sh

echo "\nRunning ${0}\n"

curl -sL https://install.raspap.com | bash -s -- --yes --openvpn 1 --adblock 1 
