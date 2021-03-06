#!/bin/bash -e

if [ -z ${BUILD_RUN:-} ]; then
  echo "This script can not be run directly! Aborting."
  exit 1
fi

if [ -z ${SCRIPTS:-} ]; then
  SCRIPTS=.
fi

chmod +x $SCRIPTS/scripts/*.sh

for script in \
  10-prepare \
  20-kernel \
  30-system-update \
  40-automation \
  50-languages \
  60-databases \
  70-services \
  80-tools \
  82-webtools \
  84-embedded \
  85-docker \
  86-virtualization \
  90-postprocess \
  99-cleanup
do
  echo "==============================================================================="
  echo " >>> Running $script.sh"
  echo "==============================================================================="
  "$SCRIPTS/scripts/$script.sh"
  printf "\n\n"
done

echo "All done."
