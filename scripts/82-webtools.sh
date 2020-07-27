#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- webshell
sudo emerge -vt  www-misc/shellinabox

# ---- db adminstration
sudo emerge -vt dev-db/phpmyadmin

# =================================================================
# POST-INSTALL INSTRUCTIONS
# =================================================================
# 
# If this is a new installation:
# 
# 1. Configure phpmyadmin:
# 
# a) Create config.inc.php. You can use the web-based installer
#    (this requires the 'setup' USE flag to be enabled):
# 
#    mkdir /var/www/localhost/htdocs/phpmyadmin/config
#    chown apache:apache /var/www/localhost/htdocs/phpmyadmin/config
# 
#    then go to http://localhost//phpmyadmin/setup/
# 
#    once you've saved the configuration:
# 
#    cp /var/www/localhost/htdocs/phpmyadmin/config/config.inc.php /var/www/localhost/htdocs/phpmyadmin/config.inc.php
#    rm -rf /var/www/localhost/htdocs/phpmyadmin/config
# 
# b) Alternatively, use an existing configuration:
# 
#    cp <path to existing config.inc.php file> /var/www/localhost/htdocs/phpmyadmin/
# 
# c) Alternatively, use the sample config file:
# 
#    cp /var/www/localhost/htdocs/phpmyadmin/config.sample.inc.php /var/www/localhost/htdocs/phpmyadmin/config.inc.php
# 
# 2. Be sure that the libraries/ directory is not visible. You can use the
#    provided .htaccess file.
# 
# =================================================================
# 
# If you are upgrading from an earlier version:
# 
# 1. If you are using phpmyadmin's features for master/foreign tables, be sure to read
#    http://localhost//phpmyadmin/Documentation.html#col_com
# 
#    You will need to perform the ALTER TABLE step yourself.
# 
