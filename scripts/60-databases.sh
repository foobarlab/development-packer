#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- MariaDB (MySQL)

sudo emerge -vt dev-db/mariadb
#sudo rc-update add mysql default

# initially configure mariadb (create initial databases, set root passwd)
#cat <<'DATA' | sudo tee -a /root/.my.cnf
#[client]
#host     = localhost
#user     = root
#password = BUILD_MYSQL_ROOT_PASSWORD
#DATA
#sudo sed -i 's/BUILD_MYSQL_ROOT_PASSWORD/'"$BUILD_MYSQL_ROOT_PASSWORD"'/g' /root/.my.cnf
#sudo emerge --config dev-db/mariadb
#sudo rm -f /root/.my.cnf

# FIXME adjust root password & secure install in Ansible later
# TODO secure install, see: https://www.funtoo.org/Package:MariaDB
#sudo mysql_secure_installation

# ---- PostgreSQL

sudo emerge -vt dev-db/postgresql

# ---- Sqlite

sudo emerge -vt dev-db/sqlite

# ---- Redis

#sudo emerge -vt dev-db/redis

# ---- Couchdb

sudo emerge -vt dev-db/couchdb
