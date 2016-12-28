#
#   Copyright (C) 2016 Pelagicore AB
#
DESCRIPTION = "Image for creating a Pelux image"

require recipes-core/images/core-image-bistro.bb

# Pelux components
IMAGE_INSTALL += "softwarecontainer"
