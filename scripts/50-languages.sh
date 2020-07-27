#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- LLVM

#sudo emerge -vt sys-devel/llvm	   # optional

# ---- Python

sudo emerge -vt app-vim/vimpython

# ---- Ruby

# FIXME add to Ansible role
# disable doc creation by default
#cat <<'DATA' | sudo tee -a /etc/gemrc
## we do not want ruby docs or rake
##gem: --no-rdoc --no-ri
#gem: --no-document
#DATA

sudo emerge -vt dev-lang/ruby
sudo emerge -vt dev-ruby/rubygems

# FIXME add to Ansible role
## install gems
#sudo gem install rdoc json rake racc
# update gems
#sudo gem update --system
#sudo gem pristine --all

# FIXME add to Ansible role?
#sudo emerge -vt dev-ruby/bundler
#sudo emerge -vt dev-ruby/sass

# ---- Elixir / Erlang OTP

sudo emerge -vt dev-lang/elixir dev-lang/erlang

# ---- JavaScript / node.js

# FIXME incompatible with 'bindist'
# FIXME add to ansible role
#sudo emerge -vt net-libs/nodejs
#sudo emerge -vt sys-apps/yarn

# ---- PHP

sudo emerge -vt dev-lang/php
sudo emerge -vt dev-php/xdebug
sudo emerge -vt dev-php/composer

#sudo emerge -vt dev-php/phpunit dev-php/phpunit-mock-objects   # FIXME not compiling
#sudo emerge -vt dev-php/phing   # FIXME not compiling

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

# ---- JVM stuff: Java / Scala / Groovy / Ant / Maven / Ivy / Gradle

sudo emerge -vt dev-java/openjdk-bin app-eselect/eselect-java

sudo emerge -vt dev-java/ant dev-java/ant-contrib dev-java/ant-commons-net
sudo emerge -vt dev-java/maven-bin
sudo emerge -vt dev-java/ant-ivy

sudo emerge -vt dev-lang/scala-bin dev-java/sbt-bin app-eselect/eselect-scala

sudo emerge -vt dev-java/groovy
#sudo emerge -vt dev-java/gradle     # FIXME compile error

# ---- Lua

sudo emerge -vt dev-lang/lua dev-lua/lua

# ---- Rust

#sudo emerge -vt dev-lang/rust    # optional
sudo emerge -vt app-vim/rust-vim
