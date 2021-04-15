#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- 6502 8-bit CPU programming (Commodore, Apple)

# TODO add 6502 Assembler (TASS, Acme, ...)
