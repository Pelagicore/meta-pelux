DESCRIPTION = "SWUpdate update file for core-image-pelux-minimal"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit swupdate

FILESEXTRAPATHS_prepend := "${THISDIR}/pelux-image-update/intel-corei7-64/:"

SRC_URI = "\
    file://sw-description \
    file://emmcsetup.lua \
"

# images to build before building swupdate image
IMAGE_DEPENDS = "core-image-pelux-minimal"

# images and files that will be included in the .swu image
SWUPDATE_IMAGES = "core-image-pelux-minimal"

SWUPDATE_IMAGES_FSTYPES[core-image-pelux-minimal] = ".ext3.gz"
