# Meshed-Banana-image

Scripts for preparing an Armbian image with the [reticulum stack](https://github.com/markqvist/Reticulum) and its tools/examples

## How does it work?
This repo contains an overlay directory to be used within the Armbian build system. It will copy the reticulum stack and its dependencies to `/opt/reticulum_env/` and add a modified `.profile` to `/etc/skel` of the built image, so that every user that gets created will have those copied to his home directory upon first login.

## How can I use it?

### Setup Armbian build system
Based on the instructions on [how to build Armbian images](https://docs.armbian.com/Developer-Guide_Build-Preparation/) given

- Download a [Ubuntu Jammy image](https://cloud-images.ubuntu.com/releases/22.04/release/) for the hypervisor of your choice (in my case kvm)
```
wget https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64-disk-kvm.img
```
- Boot the image in your hypervisor

- Login to the booted system and install the Armbian build system
```
apt-get -y install git
git clone https://github.com/armbian/build
cd build
```

- Run a test build without any modifications to make sure all works
```
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

### Add Meshed Banana customisation on top

- Install the overlay files from this repo inside the `build` directory
```
git clone https://github.com/Vault2501/Meshed-Banana-image.git
```

- Add `run_scripts.sh` to `userpatches/customize-image.sh`
You need to add it to the section of the selected RELEASE you want to build. Please see `userpatches/customize-image.sh_example` on how to add it e.g. to buster and bullseye builds

- Build again with the overlay added. 
Note: 
  - you can change `BUILD_MINIMAL`, `BUILD_DESKTOP` to get e.g. a UI installed.
  - if you change `RELEASE`, make sure you have `run_scripts.sh` added accordingly
  - changing `BRANCH` might make reticuum not work due to different device names

```
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

## Test the image
TBD
