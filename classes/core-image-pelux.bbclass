#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2018-2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

inherit core-image

IMAGE_FEATURES += "package-management debug-tweaks"

IMAGE_INSTALL_append = "\
    ${@bb.utils.contains("COMBINED_FEATURES", "bluetooth", "packagegroup-tools-bluetooth", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "process-containment", "softwarecontainer", "", d)} \
    swupdate \
    udev-extraconf \
"

# We do not support swupdate on qemu
IMAGE_INSTALL_remove_qemux86-64 = "\
    swupdate \
"

# GENIVI components
IMAGE_INSTALL_append = "\
    dlt-daemon         \
    dlt-daemon-systemd \
    node-state-manager \
"

# Should probably be included in some other way (dependency, package group, feature).
IMAGE_INSTALL_append = "\
    avs-device-sdk     \
    can-utils \
    connectivity-manager \
    libsocketcan \
    mopidy \
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
IMAGE_FSTYPES ?= "ext3 sdcard"

# This is needed for SWupdate artifacts
IMAGE_FSTYPES += "ext3.gz"
