#!/bin/bash

source config.sh
source pkg/base.sh

function download_bash(){
    download "https://mirrors.ibiblio.org/gnu/bash/bash-${BASH_VERSION}.tar.gz" "bash.tar.gz"
}

function extract_bash(){
    extract "bash.tar.gz"
}

function build_bash(){
  cd ${WORKING_DIR}/bash-${BASH_VERSION}
  ./configure --prefix=/ --without-bash-malloc
  make_cmd

  if [ -e ${ROOTFS_DIR}/bin/sh ]
  then
    rm ${ROOTFS_DIR}/bin/sh
  fi

  if [ -e ${ROOTFS_DIR}/bin/bash ]
  then
    rm ${ROOTFS_DIR}/bin/bash
  fi

  make DESTDIR=${ROOTFS_DIR} install
  ln -s ${ROOTFS_DIR}/bin/bash ${ROOTFS_DIR}/bin/sh
}

function make_bash(){
    download_bash
    extract_bash
    build_bash
}