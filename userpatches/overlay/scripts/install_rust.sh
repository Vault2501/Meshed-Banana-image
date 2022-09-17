#!/bin/sh

echo "\nRunning ${0}\n"

wget -O /tmp/rustup.rs https://sh.rustup.rs

echo "Installing Rust"
chmod 755 /tmp/rustup.rs
/tmp/rustup.rs -y
