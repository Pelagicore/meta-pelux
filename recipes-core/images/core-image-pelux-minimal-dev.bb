#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

require core-image-pelux-minimal.bb

# Development stuff
IMAGE_FEATURES += "tools-debug perf tools-testapps"
IMAGE_INSTALL += " packagegroup-bistro-utils"
