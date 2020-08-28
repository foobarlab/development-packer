#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- etckeeper

# see: https://etckeeper.branchable.com/
#sudo emerge -vt sys-apps/etckeeper
#sudo etckeeper init -d /etc

# ---- various version control systems (other than Git)

sudo emerge -vt \
  dev-vcs/subversion \
  dev-vcs/mercurial \
  dev-vcs/cvs

# ---- various vim plugins

sudo emerge -vt \
  app-vim/bash-support \
  app-vim/vimpython \
  app-vim/vim-go \
  app-vim/rust-vim \
  app-vim/csv \
  app-vim/align \
  app-vim/ansiesc \
  app-vim/ant_menu \
  app-vim/closetag \
  app-vim/dhcpd-syntax \
  app-vim/editorconfig-vim \
  app-vim/eselect-syntax \
  app-vim/gentoo-syntax \
  app-vim/gist \
  app-vim/gitlog \
  app-vim/greputils \
  app-vim/json \
  app-vim/notes \
  app-vim/rails \
  app-vim/scala-syntax \
  app-vim/screen \
  app-vim/securemodelines \
  app-vim/surround \
  app-vim/tagbar \
  app-vim/taglist \
  app-vim/tasklist \
  app-vim/udev-syntax \
  app-vim/vcscommand \
  app-vim/vim-commentary \
  app-vim/vim-multiple-cursors \
  app-vim/vim-spell-de \
  app-vim/vim-spell-en \
  app-vim/vim-spell-fr \
  app-vim/vim-spell-pt \
  app-vim/vimcommander \
  app-vim/vimoutliner \
  app-vim/wikipedia-syntax \
  app-vim/xsl-syntax \
  app-vim/webapi

# TODO add: app-vim/vim2hs, app-vim/vimclojure,  

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
  app-misc/colordiff \
  sys-fs/inotify-tools \
  sys-apps/exa \
  app-misc/icdiff \
  sys-apps/ripgrep \
  app-arch/pigz \
  app-shells/fzf \
  app-text/multitail \
  app-misc/jq

# ---- gfx/video utils

sudo emerge -vt media-gfx/imagemagick media-gfx/graphviz app-text/ghostscript-gpl media-video/ffmpeg
#sudo emerge -vt media-video/rtmpdump    # already pulled in by dependency
# PHP imagick ext:
sudo emerge -vt dev-php/pecl-imagick

# ---- various

#sudo emerge -vt dev-libs/protobuf          # TODO enable when needed
sudo emerge -vt dev-util/strace		        # strace for debugging
sudo emerge -vt dev-db/mysql-super-smack    # benchmark mysql/postgresql
