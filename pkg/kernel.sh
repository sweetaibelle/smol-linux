#!/bin/bash

source config.sh
source pkg/base.sh

function download_kernel(){
    download "https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-${KERNEL_VERSION}.tar.xz" "linux.tar.xz"
}

function extract_kernel(){
    extract "linux.tar.xz"
}

function build_kernel(){
  cd ${WORKING_DIR}/linux-${KERNEL_VERSION}
  make mrproper
  if [ -e ${LINUX_CFG} ]
  then
    cp ${LINUX_CFG} .config
    make_cmd oldconfig bzImage
  else
    make_cmd defconfig bzImage
  fi

  cp arch/x86/boot/bzImage ${ISO_DIR}/kernel.gz
}

function make_kernel(){
    download_kernel
    extract_kernel
    build_kernel
}