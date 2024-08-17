#!/bin/bash
set -ex

# Get the configuration vars and pull in all the packages functions
source config.sh
source pkg/package.sh

# Print off some of the variables.
echo "Script location: ${BASEDIR}"
echo "Resource location: ${RESOURCE_DIR}"
echo "Download location: ${DOWNLOAD_DIR}"
echo "Working location: ${WORKING_DIR}"
echo "Rootfs location: ${ROOTFS_DIR}"
echo "ISO location: ${ISO_DIR}"

# Make the directories, if not already there.
mkdir -p ${RESOURCE_DIR}
mkdir -p ${DOWNLOAD_DIR}
mkdir -p ${WORKING_DIR}
mkdir -p ${ROOTFS_DIR}
mkdir -p ${ISO_DIR}

# We're going to want some sort of core utils, like toybox or busybox, we need to build a root and kernel,
# maybe a shell, if not using one from the core utils, and misc packages.

# We also need some sort of init system, and that bit still needs to be properly sorted out.

build_utils "busybox"
make_rootfs
make_kernel
make_bash
build_nano

# Now we need to compress everything, add a bootloader, and make the iso.
compress_rootfs
make_syslinux
make_iso

set +ex
