#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Reference PELUX image with QtAuto frontend"

require core-image-pelux-qtauto-neptune.bb

# Development stuff
IMAGE_FEATURES += "tools-debug perf tools-testapps"
IMAGE_INSTALL += " packagegroup-bistro-utils"

