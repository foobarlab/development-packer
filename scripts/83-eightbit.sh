#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

# ---- 6502 8-bit CPU programming (Commodore, Apple)

# TODO initiate new kit like 'retro-kit'?
# TODO ebuilds for Assemblers: 64TASS, Acme, CC65, KickAss
# TODO ebuilds for Crunchers: pucrunch, exomizer
# TODO move VICE emulator from user-tools here
# TODO ebuilds for other C64 tools: sprite, char, gfx, diredit, music composing (goattracker)...
