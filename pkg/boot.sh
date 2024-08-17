#!/bin/bash

source config.sh
source pkg/base.sh

function download_syslinux(){
    download "https://mirrors.edge.kernel.org/pub/linux/utils/boot/syslinux/syslinux-${SYSLINUX_VERSION}.tar.xz" "syslinux.tar.xz"
}

function extract_syslinux(){
    extract "syslinux.tar.xz"
}

function install_syslinux(){
  cd ${ISO_DIR}
  cp ${WORKING_DIR}/syslinux-${SYSLINUX_VERSION}/bios/core/isolinux.bin .
  cp ${WORKING_DIR}/syslinux-${SYSLINUX_VERSION}/bios/com32/elflink/ldlinux/ldlinux.c32 .

  if [ -e ${ISOLINUX_CFG} ]
  then
    cp ${ISOLINUX_CFG} .
  else
    echo 'default kernel.gz initrd=rootfs.gz root=/dev/ram0 console=ttyAMA0 console=ttyS0' > ./isolinux.cfg
  fi
}

function make_syslinux(){
    download_syslinux
    extract_syslinux
    install_syslinux
}