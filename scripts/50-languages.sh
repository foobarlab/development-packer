#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# C / C++

sudo emerge -vt dev-util/cmake

# Python

sudo emerge -vt app-vim/vimpython

# Ruby

sudo emerge -vt dev-lang/ruby

# Elixir / Erlang OTP

sudo emerge -vt dev-lang/elixir dev-lang/erlang

# JavaScript / node.js

sudo emerge -vt net-libs/nodejs

# PHP

sudo emerge -vt dev-lang/php

# Go

sudo emerge -vt dev-lang/go
sudo emerge -vt app-vim/vim-go

# Java

sudo emerge -vt dev-java/openjdk
#sudo emerge -vt dev-java/ant dev-java/maven-bin dev-java/ant-ivy

# LUA

sudo emerge -vt dev-lang/lua dev-lua/lua
#sudo emerge -vt app-eselect/eselect-lua

# C#

#sudo emerge -vt dev-lang/mono

# Rust

#sudo emerge -vt dev-lang/rust
#sudo emerge -vt app-vim/rust-vim
