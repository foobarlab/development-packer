#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- Apache

sudo emerge -vt www-servers/apache
#sudo emerge -vt app-admin/apachetop
sudo emerge -vt www-apache/mod_security www-apache/modsecurity-crs
sudo emerge -vt app-admin/apachetop

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

# workaround (FL-6798):
cd /var/git/meta-repo/kits/core-server-kit/www-servers/nginx
sudo ebuild nginx-1.17.5.ebuild manifest

sudo emerge -vt www-servers/nginx
sudo emerge -vt app-admin/ngxtop

# ---- Lighttpd (optional)

#sudo emerge -vt www-servers/lighttpd

# ---- Varnish proxy cache

sudo emerge -vt www-servers/varnish

# ---- RabbitMQ

#sudo emerge -vt net-misc/rabbitmq-server	# FIXME 3.7.14 does not compile, add overlay with custom ebuild

# ---- DNSmasq

sudo emerge -vt net-dns/dnsmasq

# ---- Postfix

sudo emerge -vt mail-mta/postfix
