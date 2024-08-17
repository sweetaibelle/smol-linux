#!/bin/bash

source config.sh
source pkg/base.sh

function build_nano(){
  download "https://www.nano-editor.org/dist/v8/nano-${NANO_VERSION}.tar.xz" "nano.tar.xz"
  extract "nano.tar.xz"

  cd ${WORKING_DIR}/nano-${NANO_VERSION}
  ./configure --prefix=/usr
  make
  DESTDIR=${ROOTFS_DIR} make install
}
