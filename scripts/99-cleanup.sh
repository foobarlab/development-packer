#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# FIX: because of "/etc/profile.d/java-config-2.sh: line 22: user_id: unbound variable" we try to set the variable here
user_id=$(id -u)

sudo env-update
source /etc/profile

sudo emerge --depclean

sudo find /etc/ -name '._cfg*'				# DEBUG: list all config files needing an update
sudo find /etc/ -name '._cfg*' -print -exec cat -n '{}' \;  # DEBUG: cat all config files needing an update
sudo find /etc/ -name '._cfg*' -exec cp "{}" /vagrant \;	# backup ._cfg* files to /vagrant

sudo etc-update --verbose --preen			# auto-merge trivial changes

# prevent replacement of our modified configs:
sudo rm -f /etc/._cfg0000_boot.conf
sudo rm -f /etc/._cfg0000_genkernel.conf
sudo rm -f /etc/._cfg0000_updatedb.conf
sudo rm -f /etc/conf.d/._cfg0000_consolefont
sudo rm -f /etc/conf.d/._cfg0000_hostname

sudo find /etc/ -name '._cfg*'				# DEBUG: list all remaining config files needing an update
sudo find /etc/ -name '._cfg*' -print -exec cat -n '{}' \;  # DEBUG: cat all config files needing an update

sudo etc-update --verbose --automode -5		# force 'auto-merge' for remaining configs

sudo eselect kernel list
sudo ego boot update

sudo eix-update

sudo rm -f /etc/resolv.conf
sudo rm -f /etc/resolv.conf.bak

sudo cp -fR /var/log /vagrant	# backup all logs to /vagrant

sudo /usr/local/sbin/foo-cleanup

# simple way to claim some free space before export
sudo bash -c 'dd if=/dev/zero of=/EMPTY bs=1M 2>/dev/null' || true
sudo rm -f /EMPTY

bash -c 'cat /dev/null > ~/.bash_history && history -c && exit'
