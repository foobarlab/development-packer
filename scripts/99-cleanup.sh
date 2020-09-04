#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

user_id=$(id -u)    # FIX: because of "/etc/profile.d/java-config-2.sh: line 22: user_id: unbound variable" we try to set the variable here
sudo env-update
source /etc/profile

sudo emerge --depclean

sudo find /etc/ -name '._cfg*'				# DEBUG: list all config files needing an update
sudo find /etc/ -name '._cfg*' -print -exec cat -n '{}' \;  # DEBUG: cat all config files needing an update

# prevent replacement of our modified configs:
sudo rm -f /etc/._cfg0000_boot.conf
sudo rm -f /etc/._cfg0000_genkernel.conf
sudo rm -f /etc/._cfg0000_updatedb.conf
#sudo rm -f /etc/conf.d/._cfg0000_consolefont  # TODO remove?
#sudo rm -f /etc/conf.d/._cfg0000_hostname     # TODO remove?

sudo etc-update --verbose --preen    # auto-merge trivial changes

sudo find /etc/ -name '._cfg*'				# DEBUG: list all remaining config files needing an update
sudo find /etc/ -name '._cfg*' -print -exec cat -n '{}' \;  # DEBUG: cat all config files needing an update

sudo etc-update --verbose --automode -5		# force 'auto-merge' for remaining configs

sudo eselect kernel list
sudo ego boot update

sudo eix-update

sudo rm -f /etc/resolv.conf
sudo rm -f /etc/resolv.conf.bak

sudo rc-update       # show final runlevels
sudo genlop -u -l    # show (un)merged packages before logs are cleared

sudo /usr/local/sbin/foo-cleanup

# simple way to claim some free space before export
sudo bash -c 'dd if=/dev/zero of=/EMPTY bs=1M 2>/dev/null' || true
sudo rm -f /EMPTY

bash -c 'cat /dev/null > ~/.bash_history && history -c && exit'
