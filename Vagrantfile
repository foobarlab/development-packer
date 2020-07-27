# -*- mode: ruby -*-
# vi: set ft=ruby :

system("./config.sh >/dev/null")

$script_clean_kernel = <<SCRIPT
# clean stale kernel files
eclean-kernel
ego boot update
# clean kernel sources
cd /usr/src/linux
make distclean
# copy latest kernel config
cp /usr/src/kernel.config /usr/src/linux/.config
SCRIPT

$script_cleanup = <<SCRIPT
# stop services
/etc/init.d/rsyslog stop
# ensure all file operations finished
sync
# run zerofree at last to squeeze the last bit
# /boot (initially not mounted)
mount -o ro /dev/sda1
zerofree -v /dev/sda1
# /
mount -o remount,ro /dev/sda4
zerofree -v /dev/sda4
# swap
swapoff -v /dev/sda3
bash -c 'dd if=/dev/zero of=/dev/sda3 2>/dev/null' || true
mkswap /dev/sda3
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.box = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.hostname = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "#{ENV['BUILD_BOX_MEMORY']}"
    vb.cpus = "#{ENV['BUILD_BOX_CPUS']}"
    # customize VirtualBox settings, see also 'virtualbox.json'
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    vb.customize ["modifyvm", :id, "--chipset", "ich9"]
    vb.customize ["modifyvm", :id, "--vram", "12"]
    vb.customize ["modifyvm", :id, "--vrde", "off"]
    vb.customize ["modifyvm", :id, "--hpet", "on"]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--vtxvpid", "on"]
    vb.customize ["modifyvm", :id, "--largepages", "on"]
    # spectre meltdown mitigations, see https://www.virtualbox.org/ticket/17987
    #vb.customize ["modifyvm", :id, "--largepages", "off"]
    #vb.customize ["modifyvm", :id, "--spec-ctrl", "on"]
    #vb.customize ["modifyvm", :id, "--ibpb-on-vm-entry", "on"]
    #vb.customize ["modifyvm", :id, "--ibpb-on-vm-exit", "on"]
    #vb.customize ["modifyvm", :id, "--l1d-flush-on-sched", "off"]
    #vb.customize ["modifyvm", :id, "--l1d-flush-on-vm-entry", "on"]
    #vb.customize ["modifyvm", :id, "--nestedpaging", "off"]
  end
  # public network (bridged)
  config.vm.network "public_network", use_dhcp_assigned_default_route: true, mac: "0800273CA134", bridge: [
    "eth0",
    # TODO add alternative network cards here, see: https://www.vagrantup.com/docs/networking/public_network.html
  ]
  config.ssh.pty = true
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/vagrant', disabled: false
  # FIXME execute ansible only if BUILD_INCLUDE_ANSIBLE is set
  config.vm.provision "ansible_local" do |ansible|
    ansible.install = false
    ansible.verbose = true
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "provision.yml"
    #ansible.extra_vars = {
    #  box_version: "#{ENV['BUILD_BOX_VERSION']}"
    #}
  end
  config.vm.provision "clean_kernel", type: "shell", inline: $script_clean_kernel, privileged: true
  config.vm.provision "cleanup", type: "shell", inline: $script_cleanup, privileged: true
end
