#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

require core-image-pelux-minimal.bb

# Development stuff
IMAGE_FEATURES += "tools-debug debug-tweaks"
IMAGE_INSTALL += " packagegroup-bistro-utils"
