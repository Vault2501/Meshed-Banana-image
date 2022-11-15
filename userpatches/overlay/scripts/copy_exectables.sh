#!/bin/sh

echo "\nRunning ${0}\n"


cp /tmp/overlay/executables/system/* /usr/local/bin

# Get latest Config tool
WD=$(pwd)
cd /tmp
git clone https://github.com/Vault2501/Meshed-Banana-Config.git
cp Meshed-Banana-Config/lora_config.sh /usr/local/bin
chmod 755 /usr/local/bin/lora_config.sh
rm -rf Meshed-Banana-Config
cd $WD
