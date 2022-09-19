# Meshed Banana deployment scripts
A collection of scripts for preparing a Ambian image with the [reticulum stack](https://github.com/markqvist/Reticulum) and its tools/examples.
They are used to build the images for the [Meshed Banana LoRa Device](https://github.com/Vault2501/Meshed-Banana-Device)

## How does it work
This repo contains an overlay directory with bash scripts to be used within the Armbian build system or on an already installed image.<br>
The scripts will copy the reticulum stack and its dependencies to `/opt/reticulum_env/` and modifies `/etc/skel/.profile`, so that every user that gets created will have those copied to his home directory upon first login.

## How can I use it
You can run the scripts either by themself in an installed system to install the latest version of reticulum or add the scripts to the Armbian build system in order to create images with reticulum installed.

### Build a Meshed Banana Image 
To build a Meshed Banana image, please see [Meshed Banana Instructions](https://github.com/Vault2501/Meshed-Banana-image/wiki/Build-Meshed-Banana-Image) 

### Build a Rpi4 Image 
To build a Raspberry Pi image, please follow [Other Boards Instructions](https://github.com/Vault2501/Meshed-Banana-image/wiki/Build-RPi4-Image)

### Run Scripts in Booted System 
If you already have an image, and want to add the reticulum environment, please see [Stand Alone Instructions](https://github.com/Vault2501/Meshed-Banana-image/wiki/Run-in-Booted-System)

## FAQ
**Q:** I don't have a userpatches directory?<br>
**A:** Do a unmodified build first to create it.

**Q** The user I created can start reticulum, but then I get a permission denied error<br>
**A** Make sure the user is created using `adduser`
