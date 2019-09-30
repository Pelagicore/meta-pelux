#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Reference PELUX image with QtAuto frontend"

inherit core-image-pelux-qtauto
inherit populate_sdk_qt5

IMAGE_FEATURES += "ssh-server-openssh splash"

# This image uses neptune as the reference UI, which is one of the addons in Qt Auto packagegroup
IMAGE_INSTALL_append = "\
    coreutils \
    packagegroup-b2qt-automotive-addons \
"
