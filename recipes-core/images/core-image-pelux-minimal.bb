#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Image for creating a PELUX image"

inherit core-image-pelux

IMAGE_FEATURES += "ssh-server-openssh"

IMAGE_INSTALL_append = "\
    coreutils \
"
