#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# apache

sudo emerge -vt www-servers/apache

# nginx

# workaround (FL-6798):
cd /var/git/meta-repo/kits/core-server-kit/www-servers/nginx
sudo ebuild nginx-1.17.5.ebuild manifest

sudo emerge -vt www-servers/nginx

# lighttpd (optional)

#sudo emerge -vt www-servers/lighttpd

# varnish proxy cache

sudo emerge -vt www-servers/varnish

# message broker

#sudo emerge -vt net-misc/rabbitmq-server	# FIXME 3.7.14 does not compile, add overlay with custom ebuild

# dnsmasq

sudo emerge -vt net-dns/dnsmasq

# procmail

sudo emerge -vt mail-mta/postfix
