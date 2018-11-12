#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2018 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Image for creating a Pelux image"

inherit core-image-pelux

IMAGE_INSTALL_append = "\
    coreutils \
"
