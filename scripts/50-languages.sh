#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- LLVM

#sudo emerge -vt sys-devel/llvm	   # optional

# ---- Python

sudo emerge -vt dev-python/pip dev-python/sphinx app-vim/vimpython
#sudo emerge -vt dev-python/virtualenv

# ---- Ruby

# disable doc creation by default
cat <<'DATA' | sudo tee -a /etc/gemrc
# if you do not want ruby docs or rake
#gem: --no-rdoc --no-ri
# or
#gem: --no-document
DATA

sudo emerge -vt dev-lang/ruby dev-ruby/rubygems dev-ruby/bundler dev-ruby/sass

# ---- JVM stuff: Java / Scala / Groovy / Ant / Maven / Ivy / Gradle

sudo emerge -vt dev-java/openjdk-bin app-eselect/eselect-java \
                dev-java/ant dev-java/ant-contrib dev-java/ant-commons-net \
                dev-java/maven-bin dev-java/ant-ivy \
                dev-lang/scala-bin dev-java/sbt-bin app-eselect/eselect-scala \
                dev-java/groovy

# set our default java vm (user/system)
eselect java-vm show
sudo eselect java-vm set system openjdk-bin-11
eselect java-vm set user openjdk-bin-11
eselect java-vm show

# ---- Elixir / Erlang OTP

sudo emerge -vt dev-lang/elixir dev-lang/erlang

# add epmd to default runlevel (needed for couchdb/rabbitmq)
#sudo rc-update add epmd default

# ---- JavaScript / node.js

# TODO try nodeenv (pip install)
# see https://github.com/ekalinin/nodeenv

# TODO try gentoo ebuild

# TODO try src install with custom ebuild

# ---- PHP

sudo emerge -vt dev-lang/php dev-php/xdebug dev-php/composer

# ---- Go

sudo emerge -vt dev-lang/go app-vim/vim-go

# Go apps in /opt/go:
sudo mkdir -p /opt/go
cat <<'DATA' | sudo tee -a /root/.bashrc
# we want our apps to be in /opt/go
export GOPATH=/opt/go
export PATH=$PATH:$GOPATH/bin

DATA
cat <<'DATA' | sudo tee -a /root/.zshrc
# we want our apps to be in /opt/go
export GOPATH=/opt/go
export PATH=$PATH:$GOPATH/bin

DATA
cat <<'DATA' | sudo tee -a ~vagrant/.bashrc
# include go apps installed by root to our PATH
export PATH=$PATH:/opt/go/bin

DATA
cat <<'DATA' | sudo tee -a ~vagrant/.zshrc
# include go apps installed by root to our PATH
export PATH=$PATH:/opt/go/bin

DATA

user_id=$(id -u)    # FIX: because of "/etc/profile.d/java-config-2.sh: line 22: user_id: unbound variable" we try to set the variable here
sudo env-update
source /etc/profile
sudo go env

# ---- Lua

sudo emerge -vt dev-lang/lua dev-lua/lua

# ---- Rust

sudo emerge -vt dev-lang/rust-bin app-vim/rust-vim
