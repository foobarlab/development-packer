#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# common web servers

sudo emerge -vt www-servers/nginx
sudo emerge -vt www-servers/apache

# proxy caches

sudo emerge -vt www-servers/varnish

# TODO redis, rabbitmq
