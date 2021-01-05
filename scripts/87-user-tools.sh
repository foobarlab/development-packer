#!/bin/bash -uex

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi


# ---- various user/client related software

# TODO add www-client/ungoogled-chromium?

sudo emerge -nuvtND --with-bdeps=y \
    www-client/firefox-bin \
    app-emulation/vice
