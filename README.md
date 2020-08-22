# Development Vagrant box

This is a Funtoo Linux that is packaged into a Vagrant box file. Currently only a VirtualBox version is provided.
It is based on the [Funtoo Base Vagrant box](https://github.com/foobarlab/funtoo-base-packer) and provides a development environment for various programming languages and stacks.

### What's included?

 - Funtoo Linux 1.4
 - Architecture: x86-64bit, generic_64
 - 50 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP (virtio)
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default SSH authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Optional: build your own Debian Kernel 5.4
 - List of installed software:
    - Any software installed in the [base box](https://github.com/foobarlab/funtoo-base-packer)
    - Optional: *Ansible* (for automation, default: enabled)
    - Optional: *Docker* (for containerization, default: enabled)
    - Programming languages: *Elixir, Erlang, PHP, Go, Java, Kotlin, Ruby, Python, Lua, Rust, Node.js*
    - Build tools: *Ant, Maven, Ivy*
    - Mail servers: *Postfix*
    - Web Servers: *Apache, Nginx, Caddy, Varnish*
    - Databases: *MariaDB, PostgreSQL, Sqlite, Redis, CouchDB*
    - File utils: *ripgrep, icdiff, inotify-tools, exa, strace*
    - Networking tools: *httpie, aria2, iperf, ethtool, iptraf-ng, nmap, bindtools, netcat, mtr, iftop, tcpdump, snort, wireshark, dnstracer, dhcpdump* and more
    - Web tools: *shellinabox, phpmyadmin*
 - Scripts for system administration in /usr/local/sbin:
    - foo-iptables: custom iptables firewall rules (restored on reboot)

### Download pre-build images

Get the latest nightly build from Vagrant Cloud: [foobarlab/development](https://app.vagrantup.com/foobarlab/boxes/development)

### Build your own using Packer

#### Preparation

 - Install [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/)

#### Build a fresh VirtualBox box

 - Run ```./build.sh```, followed by ```./finalize.sh```
 
#### Quick test the box file

 - Run ```./test.sh```

#### Test Ansible provisioning (for development only)

 - Run ```./test_ansible.sh```

#### Upload the box to Vagrant Cloud (experimental)

 - Run ```./upload.sh```

### Regular use cases

#### Initialize a fresh box (initial state, any modifications are lost)

 - Run ```./init.sh```

#### Power on the box (keeping previous state)

 - Run ```./startup.sh```

### Special use cases

#### Show current build config

 - Run ```./config.sh```

#### Cleanup build environment (poweroff any Vagrant and VirtualBox machines)

 - Run ```./clean_env.sh```

#### Generate Vagrant Cloud API Token

 - Run ```./vagrant_cloud_token.sh```

#### Keep only a maximum number of boxes in Vagrant Cloud (experimental)

 - Run ```./clean_cloud.sh```

## Feedback welcome

Please create an issue.
