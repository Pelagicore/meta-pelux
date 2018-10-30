#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

require core-image-pelux-minimal.bb

# Development stuff
IMAGE_FEATURES += "tools-debug tools-testapps ssh-server-openssh"

IMAGE_INSTALL_append = "\
    openssh-sftp-server \
    packagegroup-bistro-debug-utils \
    vim \
"
