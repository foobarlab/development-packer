#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- QEMU

# FIXME:
# * You must enable KVM in your kernel to continue
# * You must enable VHOST_NET to have vhost-net support
# * If you have an Intel CPU, you must enable KVM_INTEL in your kernel configuration.

#sudo emerge -vt app-emulation/qemu app-emulation/qemu-guest-agent
#
## add user 'vagrant' to group 'kvm'
#sudo gpasswd -a vagrant kvm
#sudo udevadm trigger -c add /dev/kvm || true
#
#sudo rc-update add qemu-binfmt
#sudo rc-update add qemu-guest-agent default

# ---- LXC

#sudo emerge -vt app-emulation/lxc sys-process/criu
