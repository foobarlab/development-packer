#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

sudo emerge -vt dev-db/mariadb
sudo emerge -vt dev-db/postgresql
sudo emerge -vt dev-db/sqlite
#sudo emerge -vt dev-db/redis
#sudo emerge -vt dev-db/couchdb
