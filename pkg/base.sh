#!/bin/bash

source config.sh

function make_cmd(){
  make -j $(($(nproc --all) + 1)) $@
}

function download(){
  local url=$1
  local filename=$2

  echo "Downloading ${filename}."
  wget -c -O "${DOWNLOAD_DIR}/${filename}" ${url}
  echo "Done downloading ${filename}."
}

function extract(){
  local filename=$1
  echo "Extracting ${filename}."
  tar --skip-old-files -xvf ${DOWNLOAD_DIR}/${filename} -C ${WORKING_DIR}
  echo "Done extracting ${filename}."
}

function make_rootfs(){
  cd ${ROOTFS_DIR}
  #mkdir -p dev proc sys
  mkdir -p ${ROOTFS_DIR}/{dev,etc/rc,home,mnt,proc,root,sys,tmp/run,usr/{bin,sbin,lib},var}
  chmod a+rwxt ${ROOTFS_DIR}/tmp
  ##if [ -e ${INIT_SCRIPT} ]
  #then
  #  cp ${INIT_SCRIPT} .
  #else
  #  echo '#!/bin/sh' > init
  #  echo 'dmesg -n 1' >> init
  #  echo 'mount -t devtmpfs none /dev' >> init
  #  echo 'mount -t proc none /proc' >> init
  #  echo 'mount -t sysfs none /sys' >> init
  #  echo 'setsid cttyhack /bin/sTOYBOX_CFGh' >> init
  #fi

  #chmod +x init
}

function compress_rootfs(){
  cd ${ROOTFS_DIR}

  find . | cpio -R root:root -H newc -o | gzip > ${ISO_DIR}/rootfs.gz
}

function make_iso(){
  cd ${ISO_DIR}
  xorriso \
    -as mkisofs \
    -o ${ISO_NAME} \
    -b isolinux.bin \
    -c boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    ./
  cd ..
}
