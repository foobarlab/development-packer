#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- Apache

sudo emerge -vt www-servers/apache www-apache/mod_security www-apache/modsecurity-crs app-admin/apachetop

# set global server name to avoid annoying warning message on startup
cat <<'DATA' | sudo tee -a /etc/apache2/httpd.conf

# apache global server name:
ServerName BUILD_BOX_NAME

DATA
sudo sed -i 's/BUILD_BOX_NAME/'"$BUILD_BOX_NAME"'/g' /etc/apache2/httpd.conf

# configure apache to use PHP: enable '-D PHP' in APACHE2_OPTS if not already enabled ...
#sudo grep -e '-D PHP' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D PHP"/g' /etc/conf.d/apache2

# configure apache to use PHP: enable '-D PHP' in APACHE2_OPTS if not already enabled ...
#sudo grep -e '-D SECURITY' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D SECURITY"/g' /etc/conf.d/apache2

#sudo rc-update add apache2 default

# ---- Nginx

sudo emerge -vt www-servers/nginx app-admin/ngxtop

# ---- Lighttpd

sudo emerge -vt www-servers/lighttpd

# ---- Varnish proxy cache

sudo emerge -vt www-servers/varnish

# ---- RabbitMQ

sudo emerge -vt net-misc/rabbitmq-server

# ---- DNSmasq

sudo emerge -vt net-dns/dnsmasq

# ---- Postfix

sudo emerge -vt mail-mta/postfix

# ---- Avahi / mDNS

sudo emerge -vt net-dns/avahi sys-auth/nss-mdns
