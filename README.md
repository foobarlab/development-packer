# Development Vagrant box

This is a Funtoo Linux that is packaged into a Vagrant box file. Currently only a VirtualBox version is provided.
It is based on the [Funtoo Base Vagrant box](https://github.com/foobarlab/funtoo-base-packer) and provides a development environment for various programming languages and stacks.

### What's included?

 - Funtoo Linux 1.4
 - Architecture: x86-64bit, generic_64
 - 40 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP (virtio)
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default SSH authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Optional: build your own Debian Kernel 5.4
 - List of installed software:
    - Any software installed in the [base box](https://github.com/foobarlab/funtoo-base-packer)
    - Optional: *Ansible* (for automation, default: enabled)
    - Optional: *Docker* (for containerization, default: enabled)
    - Languages: *Elixir*, *Erlang OTP*, *PHP*, *Go*, *Java*, *Ruby*, *Python*, *Lua*
    - Build tools: *Ant*, *Maven*, *Ivy*
    - Web Servers: *Apache*, *Nginx*, *Varnish*
    - Databases: *MariaDB*, *PostgreSQL*, *Sqlite*, *Redis*, *CouchDB*
    - Network tools: *iperf*, *ethtool*, *iptraf-ng*, *nmap*, *bindtools*, *netcat*, *iftop*, *tcpdump*, *snort*, *wireshark*

### Download pre-build images

Get the latest build from Vagrant Cloud: [foobarlab/development](https://app.vagrantup.com/foobarlab/boxes/development)

### Build your own using Packer

#### Preparation

 - Install [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/)

#### Build a fresh VirtualBox box

 - Run ```./build.sh```
 
#### Quick test the box file

 - Run ```./test.sh```

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

#### Cleanup build environment (poweroff all Vagrant and VirtualBox machines)

 - Run ```./clean_env.sh```

#### Generate Vagrant Cloud API Token

 - Run ```./vagrant_cloud_token.sh```

#### Keep only a maximum number of boxes in Vagrant Cloud (experimental)

 - Run ```./clean_cloud.sh```

## Feedback welcome

Please create an issue.
