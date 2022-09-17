# Meshed Banana deployment scripts
A collection of scripts for preparing an Armbian image with the [reticulum stack](https://github.com/markqvist/Reticulum) and its tools/examples.
They are used to buld the images for the [Meshed Banana LoRa Device](https://github.com/Vault2501/Meshed-Banana-Device)

# Table of contents
- [How does it work](https://github.com/Vault2501/Meshed-Banana-image#how-does-it-work)
- [How can I use it](https://github.com/Vault2501/Meshed-Banana-image#how-can-i-use-it)
  - [Build a Modified Armbian Image with it](https://github.com/Vault2501/Meshed-Banana-image#build-a-modified-armbian-image-with-it)
    - [Install the Armbian Build System](https://github.com/Vault2501/Meshed-Banana-image#install-the-armbian-build-bystem)
    - [Add the Meshed Banana Customisation](https://github.com/Vault2501/Meshed-Banana-image#add-the-meshed-banana-customisation)
    - [First Image Boot](https://github.com/Vault2501/Meshed-Banana-image##first-image-boot)
  - [Run Scripts on Installed Debian Based System](https://github.com/Vault2501/Meshed-Banana-image#run-scripts-on-installed-debian-based-system)
    - [Install Requirements and run Scripts](https://github.com/Vault2501/Meshed-Banana-image#install-requirements-and-run-scripts)
    - [Copying the Environment for an Existing User](https://github.com/Vault2501/Meshed-Banana-image#copying-the-environment-for-an-existing-user)
- [Creating new Users](https://github.com/Vault2501/Meshed-Banana-image#creating-new-users)
- [FAQ](https://github.com/Vault2501/Meshed-Banana-image#faq)

## How does it work
This repo contains an overlay directory with bash scripts to be used within the Armbian build system or on an already installed image.<br>
The scripts will copy the reticulum stack and its dependencies to `/opt/reticulum_env/` and modifies `/etc/skel/.profile`, so that every user that gets created will have those copied to his home directory upon first login.

## How can I use it
You can run the scripts either by themself in an installed system to install the latest version of reticulum or add the scripts to the Armbian build system in order to create images with reticulum installed.

### Build a Modified Armbian Image with it
To use the scripts within the Armbian build system to create Armbian images with reticulum installed, follow the instructions in this section.

#### Install the Armbian Build Bystem
Based on the instructions on [how to build Armbian images](https://docs.armbian.com/Developer-Guide_Build-Preparation/):

- Download a [Ubuntu Jammy image](https://cloud-images.ubuntu.com/releases/22.04/release/) for the hypervisor of your choice (in my case kvm)

  ```bash
  wget https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64-disk-kvm.img
  ```

- Boot the image in your hypervisor
  Minimum system requirements:
  - Disk size: 60GB
  - Ram: 8GB 

- Login to the booted system and install the [Armbian build system](https://github.com/armbian/build)

  ```bash
  cd ~
  apt-get -y install git
  git clone https://github.com/armbian/build
  cd build
  ```

- Run a test build without any modifications to make sure all works and to get the `userpatches` directory created

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

#### Add the Meshed Banana Customisation

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

#### First Image Boot
Upon first boot, Armbian provides a setup process for configuring the root password, as well creating a user and connecting to wifi. After this setup is finished, logout and login as the newly created user. At this first login, the reticulum files are copied into the users home. After that, please logout and login again, to have the reticulum binaries in your `PATH`.

Here an example of the Armbian first boot

![](https://raw.githubusercontent.com/wiki/Vault2501/Meshed-Banana-image/images/bpi_zero_bootup_new.GIF)

### Run Scripts on Installed Debian Based System
If you already have an image, and want to add the reticulum environment, you can also run the scripts outside the Armbian build system.

#### Install Requirements and run Scripts
To install reticulum on an existing image, use the following instructions.

- Install git
  ```
  apt-get install -y git
  ```

- Clone the Meshed Banana repo
  ```
  git clone https://github.com/Vault2501/Meshed-Banana-image.git
  ```

- Run the scripts

  Notes:
  - Set `BOARD` other than `bananapim2zero`to not get the bPi zero specific changes
  - Currently the required group gets not set for new users, this needs to be done manually
  - `.profile` ins /etc/skel gets overwritten with a modified one
  ```
  sudo BOARD=bananapim2zero ./Meshed-Banana-image/userpatches/overlay/run_scripts.sh
  ```


#### Copying the Environment for an Existing User
If you want to add the reticulum environment for an existing user, please run the following comand:
```
cp -r /opt/reticulum_env/. $HOME
```
After that, you should be able to directly use the reticulum binaries.


### Creating new Users
If you create a new user that should be setup to use reticulum, you need to use the `adduser` command and **NOT** `useradd`, as the latter won't add the user to required groups. So in order to create new users with everything prepared run this command:
```
adduser USERNAME
```

## FAQ
**Q:** I don't have a userpatches directory?<br>
**A:** Do a unmodified build first to create it.

**Q** The user I created can start reticulum, but then I get a permission denied error<br>
**A** Make sure the user is created using `adduser`
