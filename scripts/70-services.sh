#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- Apache

sudo emerge -uvt www-servers/apache www-apache/mod_security www-apache/modsecurity-crs app-admin/apachetop

# add some more (optional) modules
sudo emerge -uvt \
	www-apache/mod_bw \
	www-apache/mod_common_redirect \
	www-apache/mod_dnsbl_lookup \
	www-apache/mod_evasive \
	www-apache/mod_fcgid \
	www-apache/mod_geoip2 \
	www-apache/mod_limitipconn \
	www-apache/mod_log_sql \
	www-apache/mod_qos \
	www-apache/mod_tidy \
	www-apache/mod_umask \
	www-apache/mod_xsendfile

# TESTING: www-apache/mod_dnssd

# set global server name to avoid annoying warning message on startup
cat <<'DATA' | sudo tee -a /etc/apache2/httpd.conf

# apache global server name:
ServerName BUILD_BOX_NAME

DATA
sudo sed -i 's/BUILD_BOX_NAME/'"$BUILD_BOX_NAME"'/g' /etc/apache2/httpd.conf

# set some DEFINE flags to enable stuff:
#  AUTH_DIGEST  Enables mod_auth_digest
#  AUTHNZ_LDAP  Enables authentication through mod_ldap (available if USE=ldap)
#  CACHE        Enables mod_cache
#  DAV          Enables mod_dav
#  ERRORDOCS    Enables default error documents for many languages.
#  INFO         Enables mod_info, a useful module for debugging
#  LANGUAGE     Enables content-negotiation based on language and charset.
#  LDAP         Enables mod_ldap (available if USE=ldap)
#  MANUAL       Enables /manual/ to be the apache manual (available if USE=docs)
#  MEM_CACHE    Enables default configuration mod_mem_cache
#  PROXY        Enables mod_proxy
#  SSL          Enables SSL (available if USE=ssl)
#  STATUS       Enabled mod_status, a useful module for statistics
#  SUEXEC       Enables running CGI scripts (in USERDIR) through suexec.
#  USERDIR      Enables /~username mapping to /home/username/public_html

sudo grep -e '-D LANGUAGE' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D LANGUAGE"/g' /etc/conf.d/apache2
sudo grep -e '-D PHP' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D PHP"/g' /etc/conf.d/apache2
sudo grep -e '-D SECURITY' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D SECURITY"/g' /etc/conf.d/apache2
sudo grep -e '-D PROXY' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D PROXY"/g' /etc/conf.d/apache2
sudo grep -e '-D STATUS' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D STATUS"/g' /etc/conf.d/apache2
sudo grep -e '-D ERRORDOCS' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D ERRORDOCS"/g' /etc/conf.d/apache2
sudo grep -e '-D AUTH_DIGEST' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D AUTH_DIGEST"/g' /etc/conf.d/apache2
sudo grep -e '-D CACHE' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D CACHE"/g' /etc/conf.d/apache2
sudo grep -e '-D FCGID' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D FCGID"/g' /etc/conf.d/apache2
#sudo grep -e '-D DNSSD' /etc/conf.d/apache2 > /dev/null || sudo sed -ir 's/APACHE2_OPTS="\(.*\)"/APACHE2_OPTS="\1 -D DNSSD"/g' /etc/conf.d/apache2	# TESTING

# hint: https://wiki.gentoo.org/wiki/Project:Apache/Troubleshooting
# hint: https://wiki.gentoo.org/wiki/Project:Apache/Upgrading

#sudo rc-update add apache2 default

# ---- Nginx

# workaround: deps needed for nginx install
sudo emerge -uvt \
	media-libs/gd \
	dev-libs/geoip

sudo emerge -uvt \
	www-servers/nginx \
	app-admin/ngxtop

# ---- Lighttpd

sudo emerge -uvt www-servers/lighttpd

# ---- Let's encrypt

sudo emerge -uvt \
	app-crypt/certbot \
	app-crypt/certbot-apache \
	app-crypt/certbot-nginx

# ---- Varnish proxy cache

sudo emerge -uvt \
	www-servers/varnish

# www-misc/varnish-modules # FIXME works in varnish 6.4 but not 6.5

# ---- RabbitMQ

sudo emerge -uvt net-misc/rabbitmq-server

# ---- DNSmasq

sudo emerge -uvt net-dns/dnsmasq
#sudo rc-update add dnsmasq default

# ---- Postfix

sudo emerge -uvt mail-mta/postfix

# ---- Avahi / mDNS

sudo emerge -uvt \
	net-dns/avahi \
	sys-auth/nss-mdns \
	dev-python/zeroconf
