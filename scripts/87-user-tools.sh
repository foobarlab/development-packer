#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi


# ---- various user/client related software

# TODO add www-client/ungoogled-chromium?

sudo emerge -nuvtND --with-bdeps=y \
    www-client/firefox-bin \
    app-emulation/vice

# ---- Sync packages

sf_vagrant="`sudo df | grep vagrant | tail -1 | awk '{ print $6 }'`"
sudo rsync -urv /var/cache/portage/packages/* $sf_vagrant/packages/
