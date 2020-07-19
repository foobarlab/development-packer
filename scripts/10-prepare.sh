#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- box name

echo "$BUILD_BOX_DESCRIPTION" >> /home/vagrant/.$BUILD_BOX_NAME
sed -i 's/<br>/\n/g' /home/vagrant/.$BUILD_BOX_NAME

# ---- /etc/motd and /etc/issue

sudo rm -f /etc/motd
cat <<'DATA' | sudo tee -a /etc/motd

Funtoo GNU/Linux Vagrant Box (BUILD_BOX_USERNAME/BUILD_BOX_NAME) - release BUILD_BOX_VERSION build BUILD_TIMESTAMP

DATA
sudo sed -i 's/BUILD_BOX_NAME/'"$BUILD_BOX_NAME"'/g' /etc/motd
sudo sed -i 's/BUILD_BOX_USERNAME/'"$BUILD_BOX_USERNAME"'/g' /etc/motd
sudo sed -i 's/BUILD_BOX_VERSION/'"$BUILD_BOX_VERSION"'/g' /etc/motd
sudo sed -i 's/BUILD_TIMESTAMP/'"$BUILD_TIMESTAMP"'/g' /etc/motd
sudo cat /etc/motd

sudo rm -f /etc/issue
cat <<'DATA' | sudo tee -a /etc/issue
This is a Funtoo GNU/Linux Vagrant Box (BUILD_BOX_USERNAME/BUILD_BOX_NAME BUILD_BOX_VERSION)

DATA
sudo sed -i 's/BUILD_BOX_VERSION/'$BUILD_BOX_VERSION'/g' /etc/issue
sudo sed -i 's/BUILD_BOX_NAME/'$BUILD_BOX_NAME'/g' /etc/issue
sudo sed -i 's/BUILD_BOX_USERNAME/'"$BUILD_BOX_USERNAME"'/g' /etc/issue
sudo cat /etc/issue

# ---- custom overlay

if [ "$BUILD_CUSTOM_OVERLAY" = true ]; then
	cd /var/git
	sudo mkdir -p overlay
	cd overlay
	# example: git clone --depth 1 -b development "https://github.com/foobarlab/foobarlab-overlay.git" ./foobarlab
	sudo git clone --depth 1 -b $BUILD_CUSTOM_OVERLAY_BRANCH "$BUILD_CUSTOM_OVERLAY_URL" ./$BUILD_CUSTOM_OVERLAY_NAME
	cd ./$BUILD_CUSTOM_OVERLAY_NAME
	sudo git config pull.rebase true
	sudo chown -R portage.portage /var/git/overlay
	cat <<'DATA' | sudo tee -a /etc/portage/repos.conf/$BUILD_CUSTOM_OVERLAY_NAME
[DEFAULT]
main-repo = core-kit

[BUILD_CUSTOM_OVERLAY_NAME]
location = /var/git/overlay/BUILD_CUSTOM_OVERLAY_NAME
auto-sync = no
priority = 10
DATA
	sudo sed -i 's/BUILD_CUSTOM_OVERLAY_NAME/'"$BUILD_CUSTOM_OVERLAY_NAME"'/g' /etc/portage/repos.conf/$BUILD_CUSTOM_OVERLAY_NAME
fi

# ---- make.conf

# disable bindist USE flag (will make this 'non-free')
#sudo sed -i 's/ bindist/ \-bindist/g' /etc/portage/make.conf

# common flags
sudo sed -i 's/USE=\"/USE="pcntl pcre /g' /etc/portage/make.conf

# Java
sudo sed -i 's/USE=\"/USE="java jce /g' /etc/portage/make.conf

# Apache webserver
sudo sed -i 's/USE=\"/USE="apache2 /g' /etc/portage/make.conf
# apache modules/mpm
# TODO consider switching to mpm-event
cat <<'DATA' | sudo tee -a /etc/portage/make.conf
# Apache config, see: https://www.funtoo.org/Package:Apache
APACHE2_MODULES="actions alias auth_basic auth_digest authn_alias authn_anon authn_core authn_dbm authn_file authz_core authz_dbm authz_groupfile authz_host authz_owner authz_user autoindex cache cgi cgid dav dav_fs dav_lock deflate dir env expires ext_filter file_cache filter headers include info log_config logio mime mime_magic negotiation rewrite setenvif socache_shmcb speling status unique_id unixd userdir usertrack vhost_alias proxy proxy_fcgi"
APACHE2_MPMS="worker"
DATA

# Nginx
cat <<'DATA' | sudo tee -a /etc/portage/make.conf
# Nginx config
# see: https://www.funtoo.org/Package:Nginx
# see: https://wiki.gentoo.org/wiki/Nginx
NGINX_MODULES_HTTP="access auth_basic autoindex browser charset empty_gif fastcgi geo gzip limit_conn limit_req map memcached proxy realip referer rewrite scgi split_clients secure_link spdy ssi ssl upstream_hash upstream_ip_hash upstream_keepalive upstream_least_conn upstream_zone userid uwsgi"
NGINX_MODULES_EXTERNAL="accept_language cache_purge modsecurity upload_progress"
DATA

# PHP
sudo sed -i 's/USE=\"/USE="fpm php /g' /etc/portage/make.conf
# php targets
cat <<'DATA' | sudo tee -a /etc/portage/make.conf
# PHP_TARGETS / PHP_TARGETS USE_EXPAND will build extensions, see: https://wiki.gentoo.org/wiki/PHP
#PHP_TARGETS="php5-6 php7-0 php7-1 php7-2 php7-3 php7-4"
PHP_TARGETS="php7-3 php7-4"
DATA

# MySQL
sudo sed -i 's/USE=\"/USE="mysql /g' /etc/portage/make.conf

# LLVM
cat <<'DATA' | sudo tee -a /etc/portage/make.conf
LLVM_TARGETS="AMDGPU BPF NVPTX X86 AArch64 ARM WebAssembly"
DATA

# various media formats
sudo sed -i 's/USE=\"/USE="imagemagick apng exif gif ico jpeg jpeg2k pdf png svg tiff truetype webp wmf mng pnm /g' /etc/portage/make.conf

sudo cat /etc/portage/make.conf

# ---- package.use

sudo mkdir -p /etc/portage/package.use
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-curl
#net-misc/curl rtmp http2 brotli	# FIXME 'http2' requires '-bindist'
net-misc/curl rtmp brotli
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-ghostscript
# required by openjdk:
>=app-text/ghostscript-gpl-9.26 cups
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-avahi
net-dns/avahi dbus mdnsresponder-compat
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-java
# customize java-jre, make it headless, see: https://wiki.gentoo.org/wiki/Java
dev-java/oracle-jre-bin headless-awt -alsa -awt -cups -fontconfig
dev-java/oracle-jdk-bin headless-awt -alsa -awt -cups -fontconfig
dev-java/icedtea-bin headless-awt -gtk -alsa -cups -webstart
dev-java/openjdk headless-awt -alsa -cups -webstart
dev-java/openjdk-bin headless-awt -alsa -cups -webstart
dev-java/openjdk-jre-bin headless-awt -alsa -cups -webstart
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-apache
www-servers/apache ssl threads
# required by www-apache/mod_security www-apache/modsecurity-crs:
dev-libs/apr-util openssl
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-nginx
www-servers/nginx threads vim-syntax google_perftools
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-php
dev-lang/php curl pdo mysql mysqli xmlwriter xmlreader apache2 argon2 bcmath calendar cgi enchant flatfile fpm inifile mhash odbc postgres soap sockets sodium spell xmlrpc xslt zip zip-encryption sqlite phar opcache tidy xpm gmp ftp
# required by www-apps/postfixadmin:
>=dev-lang/php-5.6 imap
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-erlang
dev-lang/erlang kpoll -hipe pgo odbc sctp smp -wxwidgets
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-kafka
# use embedded zookeeper for kafka:
net-misc/kafka-bin internal-zookeeper
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-imagick
# customize gnome-base/librsvg (pulled by media-gfx/imagemagick): prevent emerge of X11
gnome-base/librsvg -tools
# customize media-gfx/imagemagick (required by dev-php/pecl-imagick):
media-gfx/imagemagick -openmp
# additional supported libs for imagick:
media-gfx/imagemagick corefonts fontconfig graphviz jpeg2k postscript wmf raw heif hdri fpx lqr
# required by media-gfx/graphviz, dev-php/phpDocumentor, dev-php/phing:
media-libs/gd fontconfig
DATA
# FIXME: revert circular fixes (step 90)?
cat <<'DATA' | sudo tee -a /etc/portage/package.use/vbox-circular-temp-fix
# resolve circular dependency during install:
>=media-libs/libwebp-1.0.2 -tiff
>=media-libs/libjpeg-turbo-2.0.2 -java
>=dev-java/ant-1.9 -javamail
DATA

# ---- package.license

sudo mkdir -p /etc/portage/package.license
cat <<'DATA' | sudo tee -a /etc/portage/package.license/vbox-libpng
# required by openjdk:
>=media-libs/libpng-1.6.37 libpng2
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.license/vbox-dnswalk
>=net-dns/dnswalk-2.0.2 freedist
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.license/vbox-ffmpeg
>=media-libs/quirc-1.0 AS-IS
DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.license/vbox-llvm
>=sys-devel/llvm-9.0.1 Apache-2.0-with-LLVM-exceptions
>=sys-devel/llvm-common-9.0.1 Apache-2.0-with-LLVM-exceptions
DATA

# ---- package.mask

#sudo mkdir -p /etc/portage/package.mask
#cat <<'DATA' | sudo tee -a /etc/portage/package.mask/vbox-erlang
##>=dev-lang/erlang-23
#DATA
#cat <<'DATA' | sudo tee -a /etc/portage/package.mask/vbox-varnish
# required by varnish-modules:
##>=www-servers/varnish-6.2.0
#DATA
cat <<'DATA' | sudo tee -a /etc/portage/package.mask/vbox-rabbitmq
>=net-misc/rabbitmq-server-3.8.0
DATA

# ---- package.unmask

sudo mkdir -p /etc/portage/package.unmask
cat <<'DATA' | sudo tee -a /etc/portage/package.unmask/vbox-couchdb
# unmask dev-db/couchdb as we use our own provided version (was masked because of gentoo bugs):
# Pacho Ramos <pacho@gentoo.org> (11 Nov 2018): Unmaintained, security issues (#630796, #663164). Removal in a month.
>=dev-db/couchdb-2.3.0
DATA

# --- always copy kernel.config to current kernel src

sudo cp -f /usr/src/kernel.config /usr/src/linux/.config

# --- sync

sudo ego sync

# --- mix-ins

sudo epro mix-ins +media
sudo epro list

# FIX: because of "/etc/profile.d/java-config-2.sh: line 22: user_id: unbound variable" we try to set the variable here
user_id=$(id -u)

sudo env-update
source /etc/profile
