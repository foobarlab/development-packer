#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo emerge -vtuDN --with-bdeps=y @world

sudo etc-update --verbose --preen

sudo emerge -vt @preserved-rebuild

# FIX: because of "/etc/profile.d/java-config-2.sh: line 22: user_id: unbound variable" we try to set the variable here
user_id=$(id -u)

sudo env-update
source /etc/profile
