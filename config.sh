#!/bin/bash

. version.sh

export BUILD_BOX_NAME="development"
export BUILD_BOX_USERNAME="foobarlab"

export BUILD_PARENT_BOX_NAME="funtoo-base"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="$BUILD_BOX_USERNAME/$BUILD_PARENT_BOX_NAME"

export BUILD_GUEST_TYPE="Gentoo_64"

# memory/cpus used during box creation:
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="4096"

# memory/cpus used for final box:
export BUILD_BOX_CPUS="2"
export BUILD_BOX_MEMORY="2048"

export BUILD_BOX_PROVIDER="virtualbox"

export BUILD_KERNEL=false                 # set to true to build a new kernel
export BUILD_INCLUDE_ANSIBLE=true         # if true, include Ansible for automation

export BUILD_KEEP_MAX_CLOUD_BOXES=7       # set the maximum number of boxes to keep in Vagrant Cloud

# ----------------------------! do not edit below this line !----------------------------

BUILD_BOX_RELEASE_NOTES="Development environment for various programming languages and stacks. See README for details."     # edit this to reflect actual setup

if [[ -n "$BUILD_INCLUDE_ANSIBLE" ]]; then
    if [ "$BUILD_INCLUDE_ANSIBLE" = true ]; then
        BUILD_BOX_RELEASE_NOTES="${BUILD_BOX_RELEASE_NOTES}, Ansible 2.8"     # edit this to reflect actual setup
    fi
fi

export BUILD_BOX_RELEASE_NOTES

export BUILD_TIMESTAMP="$(date --iso-8601=seconds)"

BUILD_BOX_DESCRIPTION="$BUILD_BOX_NAME version $BUILD_BOX_VERSION"
if [ -z ${BUILD_TAG+x} ]; then
    # without build tag
    BUILD_BOX_DESCRIPTION="$BUILD_BOX_DESCRIPTION"
else
    # with env var BUILD_TAG set
    # NOTE: for Jenkins builds we got some additional information: BUILD_NUMBER, BUILD_ID, BUILD_DISPLAY_NAME, BUILD_TAG, BUILD_URL
    BUILD_BOX_DESCRIPTION="$BUILD_BOX_DESCRIPTION ($BUILD_TAG)"
fi
export BUILD_BOX_DESCRIPTION="$BUILD_BOX_RELEASE_NOTES<br><br>$BUILD_BOX_DESCRIPTION<br>created @$BUILD_TIMESTAMP"

export BUILD_OUTPUT_FILE="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.box"
export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME.tmp.box"

# get the latest parent version from Vagrant Cloud API call:
. parent_version.sh

if [ $# -eq 0 ]; then
	echo "Executing $0 ..."
	echo "=== Build settings ============================================================="
	env | grep BUILD_ | sort
	echo "================================================================================"
fi
