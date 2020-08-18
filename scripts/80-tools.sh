#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- etckeeper

# see: https://etckeeper.branchable.com/
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
  net-misc/httpie \
  net-misc/geoipupdate \
  net-analyzer/tsung

# install 'minica' in GOPATH
sudo GOPATH="/opt/go" go get github.com/jsha/minica

# ---- various file utils

sudo emerge -vt \
  sys-fs/inotify-tools \
  sys-apps/exa \
  app-misc/icdiff \
  sys-apps/ripgrep \
  app-arch/pigz \
  app-shells/fzf \
  app-text/multitail

# ---- gfx/video utils

sudo emerge -vt media-gfx/imagemagick media-gfx/graphviz app-text/ghostscript-gpl media-video/ffmpeg
#sudo emerge -vt media-video/rtmpdump    # pulled in by dependency
# PHP imagick ext:
sudo emerge -vt dev-php/pecl-imagick

# ---- various

#sudo emerge -vt dev-libs/protobuf  # TODO enable when needed
sudo emerge -vt dev-util/strace		# strace for debugging
