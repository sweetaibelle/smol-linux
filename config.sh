#!/bin/bash

# Our base directories.
BASEDIR=$(pwd)
RESOURCE_DIR="${BASEDIR}/resources"
DOWNLOAD_DIR="${BASEDIR}/downloads"
WORKING_DIR="${BASEDIR}/working"
ROOTFS_DIR="${BASEDIR}/rootfs"
ISO_DIR="${BASEDIR}/isoimage"

# Various config files we might want.
ISOLINUX_CFG="${RESOURCE_DIR}/isolinux.cfg"
LINUX_CFG="${RESOURCE_DIR}/linux.config"
TOYBOX_CFG="${RESOURCE_DIR}/toybox.config"
BUSYBOX_CFG="${RESOURCE_DIR}/busybox.config"

# An init script? And the ISO name.
INIT_SCRIPT="${RESOURCE_DIR}/init"
ISO_NAME="${BASEDIR}/smol_linux_live.iso"

# Versions of stuff to download.
KERNEL_VERSION=6.10.1
TOYBOX_VERSION=0.8.11
BUSYBOX_VERSION=1.36.1
SYSLINUX_VERSION=6.03
BASH_VERSION=5.2.32
NANO_VERSION=8.1
