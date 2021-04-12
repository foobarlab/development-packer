#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${BUILD_INCLUDE_DOCKER:-} ]; then
  echo "BUILD_INCLUDE_DOCKER was not set. Skipping ..."
  exit 0
else
  if [ "$BUILD_INCLUDE_DOCKER" = "false" ]; then
    echo "BUILD_INCLUDE_DOCKER set to FALSE. Skipping ..."
    exit 0
  fi
fi

# ---- Docker and tooling

# TODO docker-swarm is deprecated, install docker-swarmkit

sudo emerge -nuvtND --with-bdeps=y app-emulation/docker dev-util/docker-ls app-emulation/docker-compose dev-python/docker-py
sudo /usr/share/docker/contrib/check-config.sh /usr/src/kernel.config || true
sudo usermod -aG docker vagrant
#sudo rc-update add docker default

# ---- Sync packages

sf_vagrant="`sudo df | grep vagrant | tail -1 | awk '{ print $6 }'`"
sudo rsync -urv /var/cache/portage/packages/* $sf_vagrant/packages/
