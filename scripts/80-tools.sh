#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

#sudo emerge -vt app-misc/screenfetch
#sudo screenfetch >> /etc/motd

#sudo emerge -vt sys-apps/etckeeper
#sudo etckeeper init -d /etc

# various network utils
sudo emerge -vt \
 sys-apps/progress \
 net-analyzer/tcpdump \
 net-misc/iperf \
 sys-apps/ethtool \
 net-dns/bind-tools \
 net-analyzer/iptraf-ng \
 net-analyzer/nmap \
 net-analyzer/openbsd-netcat \
 net-analyzer/iftop
