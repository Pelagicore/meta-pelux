#
#   Copyright (C) 2017 Pelagicore AB
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

TOOLCHAIN_HOST_TASK += " nativesdk-packagegroup-b2qt-automotive-qt5-toolchain-host "
TOOLCHAIN_TARGET_TASK += " packagegroup-b2qt-automotive-qt5-toolchain-target qtapplicationmanager-staticdev"
