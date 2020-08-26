#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- MariaDB (MySQL)

sudo emerge -vt dev-db/mariadb dev-db/mariadb-connector-c dev-db/mysqltuner
#sudo rc-update add mysql default

# initially configure mariadb (create initial databases, set root passwd)
cat <<'DATA' | sudo tee -a /root/.my.cnf
[client]
host     = localhost
user     = root
password = BUILD_MYSQL_ROOT_PASSWORD
DATA
sudo sed -i 's/BUILD_MYSQL_ROOT_PASSWORD/'"$BUILD_MYSQL_ROOT_PASSWORD"'/g' /root/.my.cnf
sudo emerge --config dev-db/mariadb || true    # FIXME this actually fails, but /var/lib/mysql is populated ...
sudo rm -f /root/.my.cnf

# various mysql integrations
sudo emerge -vt dev-python/pymysql dev-python/mysqlclient

# ---- PostgreSQL

sudo emerge -vt dev-db/postgresql app-eselect/eselect-postgresql

# basic configuration
sudo emerge --config dev-db/postgresql || true

# ---- Sqlite

sudo emerge -vt dev-db/sqlite

# ---- Redis

sudo emerge -vt dev-db/redis

# ---- Couchdb

sudo emerge -vt dev-db/couchdb
