#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- QEMU

sudo emerge -uvt \
	app-emulation/qemu \
	app-emulation/qemu-guest-agent

# TODO load kvm kernel module?

# add user 'vagrant' to group 'kvm'
sudo gpasswd -a vagrant kvm
sudo udevadm trigger -c add /dev/kvm || true

#sudo rc-update add qemu-binfmt default
#sudo rc-update add qemu-guest-agent default

# TODO https://wiki.qemu.org/Documentation/9psetup

# ---- LXC

# 'criu' provides checkpoint/restore functionality
sudo emerge -uvt \
	sys-process/criu \
	app-emulation/lxc

# ---- LibVirt

sudo emerge -uvt \
	app-emulation/libvirt \
	app-emulation/spice

# add user 'vagrant' to group 'libvirt' for administrative access
sudo gpasswd -a vagrant libvirt

# FIXME edit /etc/conf.d/libvirtd?

#sudo rc-update add libvirt-guests default
