#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# TODO BUILD_INCLUDE_DOCKER option

# Docker and tooling

sudo emerge -vt app-emulation/docker
sudo /usr/share/docker/contrib/check-config.sh

cat <<'DATA' | sudo tee -a /etc/docker/daemon.json
{
    "debug": true
}
DATA

sudo usermod -aG docker vagrant

#sudo rc-update add docker default

#sudo emerge -vt app-emulation/docker-swarm
sudo emerge -vt dev-util/docker-ls
sudo emerge -vt app-emulation/docker-compose
