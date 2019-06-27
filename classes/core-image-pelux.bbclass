#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2018-2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

inherit core-image

IMAGE_FEATURES += "package-management debug-tweaks"

# Include softwarecontainer only if the process-containment feature has been enabled
IMAGE_INSTALL_append = "\
    ${@bb.utils.contains("DISTRO_FEATURES", "process-containment", "softwarecontainer", "", d)} \
"

# Include bluetooth if the machine supports it (MACHINE_FEATURES), and it has
# been selected in DISTRO_FEATURES.
IMAGE_INSTALL_append = "\
    ${@bb.utils.contains("COMBINED_FEATURES", "bluetooth", "packagegroup-tools-bluetooth", "", d)} \
"

# GENIVI components
IMAGE_INSTALL_append = "\
    dlt-daemon         \
    dlt-daemon-systemd \
    node-state-manager \
"

# Alexa SDK
IMAGE_INSTALL_append = "\
    avs-device-sdk     \
"

# CAN utilities
IMAGE_INSTALL_append = "\
    libsocketcan \
    can-utils \
"

# Media playback daemon
IMAGE_INSTALL_append = "\
    mopidy \
"

# OTA mechanism
IMAGE_INSTALL_append = "\
    swupdate \
"

# We do not support swupdate on qemu
IMAGE_INSTALL_remove_qemux86-64 = "\
    swupdate \
"

# Connectivity Manager
IMAGE_INSTALL_append = "\
    connectivity-manager \
"

IMAGE_INSTALL_append_arp = "\
    arp-driver \
"

TOOLCHAIN_HOST_TASK += "\
    nativesdk-cmake \
    nativesdk-gdbus-codegen-glibmm \
    nativesdk-meson \
"

IMAGE_ROOTFS_SIZE ?= "1000000"

# This is needed for SWupdate artifacts
IMAGE_FSTYPES += "ext3.gz"
