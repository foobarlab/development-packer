#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- QEMU

# FIXME: check kernel config:
# * You must enable KVM in your kernel to continue
# * You must enable VHOST_NET to have vhost-net support
# * If you have an Intel CPU, you must enable KVM_INTEL in your kernel configuration.

sudo emerge -vt app-emulation/qemu app-emulation/qemu-guest-agent

# TODO load kvm kernel module, enable in module config

# add user 'vagrant' to group 'kvm'
sudo gpasswd -a vagrant kvm
sudo udevadm trigger -c add /dev/kvm || true

#sudo rc-update add qemu-binfmt default
#sudo rc-update add qemu-guest-agent default

# ---- LXC

# FIXME for checkpoint/restore install 'sys-process/criu' and set linux kernel config:
# * CONFIG_CHECKPOINT_RESTORE:	 is not set when it should be.
# * CONFIG_NETLINK_DIAG:	     is not set when it should be.

#sudo emerge -vt sys-process/criu

# * For openrc, there is an init script provided with the package.
# * You _should_ only need to symlink /etc/init.d/lxc to
# * /etc/init.d/lxc.configname to start the container defined in
# * /etc/lxc/configname.conf.
# * 
# * If you want checkpoint/restore functionality, please install criu
# * (sys-process/criu).
# * 
# * (Note: Above message is only printed the first time package is
# * installed. Please look at /usr/share/doc/lxc-3.0.4-r1/README.gentoo*
# * for future reference)

# FIXME: set linux kernel config for lxc:
# * Checking for suitable kernel configuration options...
# *   CONFIG_NETFILTER_XT_CONNMARK:	 is not set when it should be.
# *   CONFIG_NETFILTER_XT_TARGET_CHECKSUM:	 is not set when it should be.

sudo emerge -vt app-emulation/lxc

# ---- LibVirt

# * Important: The openrc libvirtd init script is now broken up into two
# * separate services: libvirtd, that solely handles the daemon, and
# * libvirt-guests, that takes care of clients during shutdown/restart of the
# * host. In order to reenable client handling, edit /etc/conf.d/libvirt-guests
# * and enable the service and start it:
# * 
# * $ rc-update add libvirt-guests
# * $ service libvirt-guests start
# * 
# * 
# * For the basic networking support (bridged and routed networks) you don't
# * need any extra software. For more complex network modes including but not
# * limited to NATed network, you can enable the 'virt-network' USE flag. It
# * will pull in required runtime dependencies
# * 
# * 
# * If you are using dnsmasq on your system, you will have to configure
# * /etc/dnsmasq.conf to enable the following settings:
# * 
# * bind-interfaces
# * interface or except-interface
# * 
# * Otherwise you might have issues with your existing DNS server.
# * 
# * 
# * For openrc users:
# * 
# * Please use /etc/conf.d/libvirtd to control the '--listen' parameter for
# * libvirtd.
# * 
# * Use /etc/init.d/libvirt-guests to manage clients on restart/shutdown of
# * the host. The default configuration will suspend and resume running kvm
# * guests with 'managedsave'. This behavior can be changed under
# * /etc/conf.d/libvirt-guests
# * 
# * 
# * If you have built libvirt with policykit support, a new group "libvirt" has
# * been created. Simply add a user to the libvirt group in order to grant
# * administrative access to libvirtd. Alternatively, drop a custom policykit
# * rule into /etc/polkit-1/rules.d.
# * 
# * If you have built libvirt without policykit support (USE=-policykit), you
# * must change the unix sock group and/or perms in /etc/libvirt/libvirtd.conf
# * in order to allow normal users to connect to libvirtd.
# * 
# * 
# * If libvirt is built with USE=caps, libvirt will now start qemu/kvm VMs
# * with non-root privileges. Ensure any resources your VMs use are accessible
# * by qemu:qemu.
# * 
# * (Note: Above message is only printed the first time package is
# * installed. Please look at /usr/share/doc/libvirt-6.7.0/README.gentoo*
# * for future reference)

sudo emerge -vt app-emulation/libvirt app-emulation/spice
