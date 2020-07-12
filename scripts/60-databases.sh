#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# MySQL

#sudo emerge -vt dev-db/mysql
#sudo emerge -vt dev-db/mysqltuner

# Maria DB

sudo emerge -vt dev-db/mariadb

# PostgresSQL

sudo emerge -vt dev-db/postgresql
#sudo emerge -vt app-eselect/eselect-postgresql

# Sqlite

sudo emerge -vt dev-db/sqlite

# TODO couchdb
