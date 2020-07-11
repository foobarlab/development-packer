#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_KERNEL:-} ]; then
    echo "BUILD_KERNEL was not set. Skipping kernel rebuild."
    exit 0
else
    if [ "$BUILD_KERNEL" = false ]; then
        echo ">>> Skipping kernel rebuild."
        exit 0
    else
        echo ">>> Rebuilding kernel ..."
    fi
fi

sudo mv -f /usr/src/kernel.config /usr/src/kernel.config.old
sudo cp ${SCRIPTS}/scripts/kernel.config /usr/src

sudo eselect kernel list
sudo emerge -vt sys-kernel/debian-sources

sudo eselect kernel list
sudo eselect kernel set 1
sudo eselect kernel list

cd /usr/src/linux

# apply 'make olddefconfig' on 'kernel.config' in case kernel config is outdated
sudo cp /usr/src/kernel.config /usr/src/kernel.config.old
sudo mv -f /usr/src/kernel.config /usr/src/linux/.config
sudo make olddefconfig
sudo mv -f /usr/src/linux/.config /usr/src/kernel.config

sudo genkernel all

cd /usr/src

sudo env-update
source /etc/profile

sudo mv /etc/boot.conf /etc/boot.conf.old
cat <<'DATA' | sudo tee -a /etc/boot.conf
boot {
    generate grub
    default "Funtoo Linux"
    timeout 1
}
display {
	gfxmode 800x600
}
"Funtoo Linux" {
    kernel kernel[-v]
    initrd initramfs[-v]
    params += real_root=/dev/sda4 root=PARTLABEL=rootfs rootfstype=ext4
}
DATA

sudo ego boot update
