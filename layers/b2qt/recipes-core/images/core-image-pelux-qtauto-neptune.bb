#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Reference PELUX image with QtAuto frontend"

inherit core-image-pelux-qtauto
inherit populate_sdk_qt5

# This image uses neptune as the reference UI, which is one of the addons in Qt Auto packagegroup
IMAGE_INSTALL += " packagegroup-b2qt-automotive-addons "
