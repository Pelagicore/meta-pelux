#
#   Copyright (C) 2017 Pelagicore AB
#

DESCRIPTION = "Image for creating a Pelux image"

require recipes-core/images/core-image-bistro-dev.bb

# Pelux components
IMAGE_INSTALL += "softwarecontainer"

# GENIVI components
IMAGE_INSTALL += " dlt-daemon         \
                   dlt-daemon-systemd \
                 "
