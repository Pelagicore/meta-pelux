#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

require core-image-pelux-minimal.bb

# Development stuff
IMAGE_FEATURES += "tools-debug tools-testapps"

IMAGE_INSTALL_append = "\
    openssh-sftp-server \
    packagegroup-bistro-debug-utils \
    vim \
"
