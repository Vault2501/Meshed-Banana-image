# Meshed Banana deployment scripts
A collection of scripts for preparing an Armbian image with the [reticulum stack](https://github.com/markqvist/Reticulum) and its tools/examples.
They are used to buld the images for the [Meshed Banana LoRa Device](https://github.com/Vault2501/Meshed-Banana-Device)

## How does it work?
This repo contains an overlay directory with bash scripts to be used within the Armbian build system or on an already installed image.<br>
The scripts will copy the reticulum stack and its dependencies to `/opt/reticulum_env/` and add a modified `.profile` to `/etc/skel`, so that every user that gets created will have those copied to his home directory upon first login.

## How can I use it?
You can run the script either by themself in an installed system to install the latest version of reticulum or add the scripts to the Armbian build system in order to create images with reticulum installed.

### Build a Modified Armbian Image with it
To use the scripts within the Armbian build system to create Armbian images with reticulum installed, follow the instructions in this section.

#### Install the Armbian Build Bystem
Based on the instructions on [how to build Armbian images](https://docs.armbian.com/Developer-Guide_Build-Preparation/) given:

- Download a [Ubuntu Jammy image](https://cloud-images.ubuntu.com/releases/22.04/release/) for the hypervisor of your choice (in my case kvm)

  ```bash
  wget https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64-disk-kvm.img
  ```

- Boot the image in your hypervisor

- Login to the booted system and install the [Armbian build system](https://github.com/armbian/build)

  ```bash
  cd ~
  apt-get -y install git
  git clone https://github.com/armbian/build
  cd build
  ```

- Run a test build without any modifications to make sure all works and to get the `userpatches directory created`

  ```bash
  ./compile.sh  \
      BOARD=bananapim2zero \
      BRANCH=current \
      RELEASE=bullseye \
      BUILD_MINIMAL=yes \
      BUILD_DESKTOP=no \
      KERNEL_ONLY=no \
      KERNEL_CONFIGURE=no \
      COMPRESS_OUTPUTIMAGE=sha,gpg,img
  ```

#### Add the Meshed Banana Customisation to the Build System

- Install the overlay files from this repo inside the `build` directory

  ```bash
  cd ~
  git clone https://github.com/Vault2501/Meshed-Banana-image.git
  cp -r Meshed-Banana-image/userpatches build
  cd build
  ```

- Add `run_scripts.sh` to `userpatches/customize-image.sh`
You need to add it to the section of the selected RELEASE you want to build. Please see `userpatches/customize-image.sh_example` on how to add it e.g. to buster and bullseye builds

- Build again with the overlay added.

  Notes: 
  - you can change `BUILD_MINIMAL`, `BUILD_DESKTOP` to get e.g. a UI installed.
  - if you change `RELEASE`, make sure you have `run_scripts.sh` added accordingly
  - changing `BRANCH` might make reticuum not work due to different device names

  ```bash
  ./compile.sh  \
      BOARD=bananapim2zero \
      BRANCH=current \
      RELEASE=bullseye \
      BUILD_MINIMAL=yes \
      BUILD_DESKTOP=no \
      KERNEL_ONLY=no \
      KERNEL_CONFIGURE=no \
      COMPRESS_OUTPUTIMAGE=sha,gpg,img
  ```

### Run Scripts on Installed Debian or Ubuntu Based System
To install reticulum on an existin image, use the following instructions:

- Install git
  ```
  apt-get install -y git
  ```

- Clone the Meshed Banana repo
  ```
  git clone https://github.com/Vault2501/Meshed-Banana-image.git
  ```

- Run the scripts
  ```
  sudo ./Meshed-Banana-image/userpatches/overlay/run_scripts.sh
  ```

## Test the Image
TBD

## FAQ
**Q:** I don't have a userpatches directory?<br>
**A:** Do a unmodified build first to create it.
