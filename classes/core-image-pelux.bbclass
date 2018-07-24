#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

inherit core-image

IMAGE_FEATURES += "package-management debug-tweaks"

# Include softwarecontainer only if the process-containment feature has been enabled
IMAGE_INSTALL += "\
    ${@bb.utils.contains("DISTRO_FEATURES", "process-containment", "softwarecontainer", "", d)} \
"

# Include bluetooth if the machine supports it (MACHINE_FEATURES), and it has
# been selected in DISTRO_FEATURES.
IMAGE_INSTALL += "\
    ${@bb.utils.contains("COMBINED_FEATURES", "bluetooth", "packagegroup-tools-bluetooth", "", d)} \
"

# GENIVI components
IMAGE_INSTALL += "\
    dlt-daemon         \
    dlt-daemon-systemd \
    node-state-manager \
"

# OTA mechanism
IMAGE_INSTALL_append_rpi += "\
    swupdate \
"

IMAGE_INSTALL_append_intel-corei7-64 = "\
    swupdate \
"

IMAGE_INSTALL_append_arp += "\
    arp-driver \
    swupdate \
"

TOOLCHAIN_HOST_TASK += "nativesdk-cmake"

# Add "/usr/lib/cmake" to the PATH variable so that CMake can find the *Config.cmake" when FIND_PACKAGE() is called from a CMake makefile
toolchain_create_sdk_env_script_append() {
	echo 'export PATH=$PATH:$SDKTARGETSYSROOT/usr/lib/cmake' >> $script
}

IMAGE_ROOTFS_SIZE ?= "1000000"
IMAGE_FSTYPES ?= "ext3 sdcard"

# This is needed for SWupdate artifacts
IMAGE_FSTYPES += "ext3.gz"
