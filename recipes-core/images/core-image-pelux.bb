#
#   Copyright (C) 2016 Pelagicore AB
#
DESCRIPTION = "Image for creating a Pelux image"

require recipes-core/images/core-image-bistro-dev.bb

# Pelux components
IMAGE_INSTALL += "softwarecontainer"
