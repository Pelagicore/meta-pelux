# Copyright (C) Luxoft Sweden AB
# Released under the MIT license (see LICENSE for the terms)

inherit core-image-pelux
inherit acrn-service-os

IMAGE_INSTALL_append = " \
    efibootmgr \
    pelux-vm \
"

IMAGE_FEATURES_append = " \
    ssh-server-openssh \
"

IMAGE_INSTALL_remove += "swupdate"
IMAGE_INSTALL_remove += "arp-driver"
