#!/bin/sh

echo "\nRunning ${0}\n"

# remove new user prompt
rm /root/.not_logged_in_yet

# set passwords
echo "root:meshedbanana" | chpasswd
