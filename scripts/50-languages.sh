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

# show/set our default java vm (user/system)
eselect java-vm show
#sudo eselect java-vm set system openjdk-bin-11
#eselect java-vm set user openjdk-bin-11
#eselect java-vm show

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

# PHP and some tools/exts, see: https://wiki.gentoo.org/wiki/PHP
sudo emerge -vt dev-lang/php dev-php/xdebug dev-php/composer dev-php/pecl-oauth dev-php/igbinary

# deprecated extensions:
#sudo emerge -vt dev-php/pecl-uploadprogress

# extensions:
#sudo emerge -vt dev-php/pecl-taint dev-php/pecl-memcached
#sudo emerge -vt dev-php/pecl-geoip dev-php/pecl-timezonedb
#sudo emerge -vt dev-php/pecl-yaml dev-php/pecl-raphf dev-php/pecl-mailparse dev-php/pecl-event dev-php/pecl-eio dev-php/pecl-redis
#sudo emerge -vt dev-php/pecl-http
#sudo emerge -vt dev-php/pecl-amqp
#sudo emerge -vt dev-php/pecl-stomp
#sudo emerge -vt dev-php/pecl-apcu dev-php/pecl-apcu_bc
#sudo emerge -vt media-gfx/imagemagick dev-php/pecl-imagick

# update PEAR/PECL channels while online
#sudo emerge -v --config PEAR-PEAR
	
# foobarlab overlay PECL packages:
#sudo emerge -vt dev-php/pecl-solr
# see: https://github.com/arnaud-lb/php-rdkafka
#sudo emerge -vt dev-php/pecl-rdkafka

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

sudo emerge -vt dev-lang/lua dev-lang/luajit

# ---- Rust

sudo emerge -vt dev-lang/rust-bin app-vim/rust-vim
