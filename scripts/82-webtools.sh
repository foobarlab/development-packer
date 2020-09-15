#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- various webtools

sudo emerge -vt \
    app-admin/webapp-config \
    www-misc/shellinabox \
    dev-db/phpmyadmin \
    www-apps/phpsysinfo \
    www-apps/postfixadmin \
    www-apps/eclipse-orion-bin
