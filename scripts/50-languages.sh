#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

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

# GO

sudo emerge -vt dev-lang/go
sudo emerge -vt app-vim/vim-go

# Java

sudo emerge -vt dev-java/openjdk
