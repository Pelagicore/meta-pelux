#
#   Copyright (C) 2017 Pelagicore AB
#

DESCRIPTION = "Image for creating a Pelux image with Qt frontend"

require recipes-core/images/core-image-pelux.bb

# Pelux components
IMAGE_INSTALL += " neptune-ui        \
                   dbus-session      \
                 "
