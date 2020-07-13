#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# MySQL (Maria DB)

sudo emerge -vt dev-db/mariadb

# PostgreSQL

sudo emerge -vt dev-db/postgresql

# Sqlite

sudo emerge -vt dev-db/sqlite

# Redis

#sudo emerge -vt dev-db/redis	# FIXME

# TODO couchdb
