#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- C / C++

sudo emerge -vt dev-util/cmake

# ---- Python

sudo emerge -vt app-vim/vimpython

# ---- Ruby

# disable doc creation by default
cat <<'DATA' | sudo tee -a /etc/gemrc
# we do not want ruby docs or rake
#gem: --no-rdoc --no-ri
gem: --no-document
DATA

sudo emerge -vt dev-lang/ruby
sudo emerge -vt dev-ruby/rubygems
## install gems
#sudo gem install rdoc json rake racc
# update gems
sudo gem update --system
sudo gem pristine --all

sudo emerge -vt dev-ruby/bundler
#sudo emerge -vt dev-ruby/sass

# ---- Elixir / Erlang OTP

sudo emerge -vt dev-lang/elixir dev-lang/erlang

# ---- JavaScript / node.js

sudo emerge -vt net-libs/nodejs
sudo emerge -vt sys-apps/yarn

# ---- PHP

sudo emerge -vt dev-lang/php
sudo emerge -vt dev-php/phing
sudo emerge -vt dev-php/xdebug
sudo emerge -vt dev-php/phpunit dev-php/phpunit-mock-objects
sudo emerge -vt dev-php/composer

# ---- Go

sudo emerge -vt dev-lang/go
sudo emerge -vt app-vim/vim-go

# Go apps in /opt/go:
sudo mkdir -p /opt/go
cat <<'DATA' | sudo tee -a /root/.bashrc

# we want our apps to be in /opt/go
export GOPATH=/opt/go
export PATH=$PATH:/opt/go/bin
DATA
cat <<'DATA' | sudo tee -a ~vagrant/.bashrc

# include go apps installed by root to our PATH
export PATH=$PATH:/opt/go/bin
DATA

# ---- Java

sudo emerge -vt dev-java/openjdk

sudo emerge -vt dev-java/ant dev-java/ant-contrib dev-java/ant-commons-net
sudo emerge -vt dev-java/maven-bin
#sudo emerge -vt dev-java/ant-ivy
sudo emerge -vt dev-lang/scala-bin dev-java/sbt-bin app-eselect/eselect-scala


# ---- LUA

sudo emerge -vt dev-lang/lua dev-lua/lua
#sudo emerge -vt app-eselect/eselect-lua

# ---- C#

#sudo emerge -vt dev-lang/mono

# ---- Rust

#sudo emerge -vt dev-lang/rust
#sudo emerge -vt app-vim/rust-vim
