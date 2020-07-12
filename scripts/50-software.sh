#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# TODO install more software, configure with ansible

sudo emerge -vt dev-lang/elixir dev-lang/erlang

sudo emerge -vt net-libs/nodejs
