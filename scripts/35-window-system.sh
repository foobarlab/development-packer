#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# TODO install additional fonts?

# TODO install tilix or roxterm or kitty + configuration
 
# TODO move all config to Ansible?

# TODO customize/refresh fluxbox usermenu?
