#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2018-2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

DESCRIPTION = "Reference PELUX image with QtAuto frontend"

require core-image-pelux-qtauto-neptune.bb

# Development stuff
IMAGE_FEATURES += "tools-debug tools-testapps ssh-server-openssh"
IMAGE_INSTALL += "\
	coreutils \
	git \
	openssh-sftp-server \
	packagegroup-bistro-debug-utils \
	vim \
"
