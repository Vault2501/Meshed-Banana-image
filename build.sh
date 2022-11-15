#!/bin/sh


LOG="build.log"
rm ${LOG}
. userpatches/overlay/image.config

echo ${BOARD}

./compile.sh \
  BOARD=${BOARD} \
  EXTERNAL=yes \
  DISABLE_IPV6=false \
  BRANCH=current \
  RELEASE=jammy \
  BUILD_MINIMAL=yes \
  BUILD_DESKTOP=no \
  KERNEL_ONLY=no \
  KERNEL_CONFIGURE=no \
  COMPRESS_OUTPUTIMAGE=sha,gpg,im | tee ${LOG} 

./userpatches/overlay/post_build/enable_hdmi_rpib4.sh $LOG
#REPOSITORY_INSTALL=u-boot,kernel,bsp,armbian-bsp-cli,armbian-config,armbian-firmware \
