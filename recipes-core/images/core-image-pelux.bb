#
#   Copyright (C) 2016 Pelagicore AB
#
DESCRIPTION = "Image for creating a Pelux image"

inherit core-image-bistro

# Pelux components
IMAGE_INSTALL += "softwarecontainer"
