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

sudo emerge -vt app-emulation/docker
#sudo /usr/share/docker/contrib/check-config.sh	# FIXME this will break

#sudo mkdir -p /etc/docker
#cat <<'DATA' | sudo tee -a /etc/docker/daemon.json
#{
#    "debug": true
#}
#DATA

sudo usermod -aG docker vagrant

#sudo rc-update add docker default

#sudo emerge -vt app-emulation/docker-swarm
#sudo emerge -vt dev-util/docker-ls
#sudo emerge -vt app-emulation/docker-compose
