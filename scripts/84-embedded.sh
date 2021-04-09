#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- Cross-tooling

sudo emerge -nuvtND --with-bdeps=y sys-devel/crossdev

# ---- ARM / AVR / Arduino

sudo emerge -nuvtND --with-bdeps=y dev-embedded/avrdude dev-embedded/avra dev-embedded/arduino-builder

# TODO configure crossdev:
#sudo crossdev -s4 avr

# ---- ESP8266/ ESP32 / STM32

sudo emerge -nuvtND --with-bdeps=y dev-embedded/esptool dev-embedded/nodemcu-uploader dev-embedded/stm32flash

# ---- Sync packages

sudo rsync -urv /var/cache/portage/packages/* /vagrant/packages/
