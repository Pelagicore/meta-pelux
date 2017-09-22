#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "PELUX image that contains the template service"

inherit core-image-pelux

IMAGE_INSTALL += "template-service"
