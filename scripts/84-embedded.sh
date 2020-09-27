#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- Cross-tooling

sudo emerge -uvt sys-devel/crossdev

# ---- ARM / AVR / Arduino

sudo emerge -uvt dev-embedded/avrdude dev-embedded/avra dev-embedded/arduino-builder

# ---- ESP8266/ ESP32 / STM32

sudo emerge -uvt dev-embedded/esptool dev-embedded/nodemcu-uploader dev-embedded/stm32flash
