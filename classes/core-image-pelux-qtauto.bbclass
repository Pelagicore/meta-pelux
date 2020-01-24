#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Class for inheriting a Pelux image with Qt frontend"

inherit core-image-pelux

# A bunch of QtAuto components
QTAUTO_COMPONENTS = " \
    qtapplicationmanager \
    qtivi \
    qtvirtualkeyboard \
"

# Classes are special so we only do this if the b2qt meta layer (which contains
# the above components) is enabled
IMAGE_INSTALL += " \
	${@bb.utils.contains("BBFILE_COLLECTIONS", "b2qt", "${QTAUTO_COMPONENTS}", "", d)} \
"

# MQTT is part of core image so add Qt interface too
IMAGE_INSTALL_append = " \
    qtmqtt \
    qtserialport \
"

IMAGE_INSTALL_append_jetson-tx2 = " \
    egl-wayland \
"

TOOLCHAIN_HOST_TASK += " nativesdk-packagegroup-b2qt-automotive-qt5-toolchain-host "
TOOLCHAIN_TARGET_TASK += " packagegroup-b2qt-automotive-qt5-toolchain-target qtapplicationmanager-staticdev"
