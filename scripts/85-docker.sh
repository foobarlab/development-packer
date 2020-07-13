#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# Docker and tooling

#sudo emerge -vt app-emulation/docker
#sudo /usr/share/docker/contrib/check-config.sh

##sudo emerge -vt app-emulation/docker-swarm
#sudo emerge -vt dev-util/docker-ls
#sudo emerge -vt app-emulation/docker-compose

##sudo rc-update add docker default
#sudo usermod -aG docker vagrant
