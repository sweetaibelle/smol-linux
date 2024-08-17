#!/bin/bash

source config.sh
source pkg/base.sh


function build_toybox(){
  cd ${WORKING_DIR}/toybox-${TOYBOX_VERSION}
  make distclean
  if [ -e ${TOYBOX_CFG} ]
  then
    cp ${TOYBOX_CFG} .config
    make_cmd oldconfig
  else
    make_cmd defconfig
    sed -i "s|.*CONFIG_STATIC.*|CONFIG_STATIC=y|" .config
  fi
  
  PREFIX=${ROOTFS_DIR} make toybox install
}

function build_busybox(){
  cd ${WORKING_DIR}/busybox-${BUSYBOX_VERSION}
  make distclean
  if [ -e ${BUSYBOX_CFG} ]
  then
    cp ${BUSYBOX_CFG} .config
    make_cmd oldconfig
  else
    make_cmd defconfig
    sed -i "s|.*CONFIG_STATIC.*|CONFIG_STATIC=y|" .config
    sed -i "s|.*CONFIG_TC.*|CONFIG_TC=n|" .config
  fi

  make busybox install
  #cp -rv _install/* ${ROOTFS_DIR}/
  #if [ -e ${ROOTFS_DIR}/linuxrc ]
  #then
  #  rm ${ROOTFS_DIR}/linuxrc
  #fi
}

function build_utils(){
  case $1 in
    "busybox")
      download "https://busybox.net/downloads/busybox-${BUSYBOX_VERSION}.tar.bz2" "busybox.tar.bz2"
      extract "busybox.tar.bz2"
      build_busybox
      ;;
    "toybox")
      download "https://www.landley.net/toybox/downloads/toybox-${TOYBOX_VERSION}.tar.gz" "toybox.tar.xz"
      extract "toybox.tar.xz"
      build_toybox
      ;;
    *)
      echo "No core utils chosen"
      ;;
  esac
}
