#!/bin/bash

. version.sh

export BUILD_BOX_NAME="development"
export BUILD_BOX_USERNAME="foobarlab"

export BUILD_PARENT_BOX_NAME="funtoo-base"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="$BUILD_BOX_USERNAME/$BUILD_PARENT_BOX_NAME"

export BUILD_GUEST_TYPE="Gentoo_64"

# memory/cpus used during box creation:
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="8192"

# memory/cpus used for final box:
export BUILD_BOX_CPUS="2"
export BUILD_BOX_MEMORY="4096"

export BUILD_BOX_PROVIDER="virtualbox"

export BUILD_CUSTOM_OVERLAY=true
export BUILD_CUSTOM_OVERLAY_NAME="foobarlab"
export BUILD_CUSTOM_OVERLAY_URL="https://github.com/foobarlab/foobarlab-overlay.git"
export BUILD_CUSTOM_OVERLAY_BRANCH="master"

# TODO make finalize step optional, like:
#export BUILD_AUTO_FINALIZE=false  # if 'true' automatically run finalize.sh script

export BUILD_KERNEL=false                 # build a new kernel?
export BUILD_WINDOW_SYSTEM=false          # build X window system (X.Org)
export BUILD_INCLUDE_ANSIBLE=false        # include Ansible? (already installed in funtoo-base)
export BUILD_INCLUDE_DOCKER=true          # include Docker?

export BUILD_KEEP_MAX_CLOUD_BOXES=1       # set the maximum number of boxes to keep in Vagrant Cloud

export BUILD_MYSQL_ROOT_PASSWORD=changeme      # set the root password for MySQL/MariaDB 

# ----------------------------! do not edit below this line !----------------------------

export BUILD_BOX_RELEASE_NOTES="Development environment based on Funtoo Linux providing various programming languages and stacks. See README in sources for details."     # edit this to reflect actual setup

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
export BUILD_BOX_DESCRIPTION="$BUILD_BOX_RELEASE_NOTES<br><br>$BUILD_BOX_DESCRIPTION<br>created @$BUILD_TIMESTAMP<br><br>Source code: https://github.com/foobarlab/development-packer"

export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.tmp.box"
export BUILD_OUTPUT_FILE_INTERMEDIATE="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.raw.box"
export BUILD_OUTPUT_FILE_FINAL="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.box"

# get the latest parent version from Vagrant Cloud API call:
. parent_version.sh

if [ $# -eq 0 ]; then
	echo "Executing $0 ..."
	echo "=== Build settings ============================================================="
	env | grep BUILD_ | sort
	echo "================================================================================"
fi
