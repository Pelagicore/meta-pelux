#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Image for creating a Pelux image with Qt frontend"

inherit core-image-pelux

# Pelux components
IMAGE_INSTALL += " neptune-ui        \
                   dbus-session      \
                 "
