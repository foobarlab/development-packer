#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# apache
sudo emerge -vt app-admin/apachetop

# some network related utils
sudo emerge -vt net-misc/iperf sys-apps/ethtool net-dns/bind-tools net-analyzer/iptraf-ng net-analyzer/nmap net-analyzer/openbsd-netcat net-analyzer/iftop

# housekeeping utils
#sudo emerge -vt sys-apps/bleachbit
