#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- etckeeper

#sudo emerge -vt sys-apps/etckeeper
#sudo etckeeper init -d /etc

# ---- various network utils

sudo emerge -vt \
  net-misc/aria2 \
  net-analyzer/tcpdump \
  net-misc/iperf \
  sys-apps/ethtool \
  net-dns/bind-tools \
  net-analyzer/iptraf-ng \
  net-analyzer/nmap \
  net-analyzer/openbsd-netcat \
  net-analyzer/iftop \
  net-dns/dnswalk \
  net-dns/dnstop \
  net-analyzer/dnstracer \
  net-analyzer/dhcpdump \
  net-analyzer/traceroute \
  net-analyzer/snort \
  net-analyzer/wireshark \
  net-analyzer/mtr \
  net-misc/httpie

# ---- various file utils

sudo emerge -vt \
  sys-fs/inotify-tools \
  sys-apps/exa \
  app-misc/icdiff \
  sys-apps/ripgrep

# TODO dev-util/diffoscope

# ---- video streaming utils

#sudo emerge -vt media-video/ffmpeg      # FIXME: not compiling
#sudo emerge -vt media-video/rtmpdump    # already pulled in as dependency

# ---- speech synthesis

sudo emerge -vt app-accessibility/speech-dispatcher    # FIXME: enable kernel modules?
