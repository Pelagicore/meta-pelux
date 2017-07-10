#
#   Copyright (C) 2017 Pelagicore AB
#

SUMMARY = "A template C/C++ service"
DESCRIPTION = "A C/C++ source code repository blueprint"
AUTHOR = "Gordan Markuš <gordan.markus@pelagicore.com>"
HOMEPAGE = "https://github.com/Pelagicore/template-service"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"
DEPENDS = "template-library"
PV = "1.0+git${SRCREV}"
PR = "r0"

SRCREV = "5bce3d20f996dac7e3882f48f5057abb7e1d05f5"
SRC_URI = "git://github.com/Pelagicore/template-service.git;protocol=https;branch=master"

S = "${WORKDIR}/git/"

inherit cmake pkgconfig

PACKAGES = " \
    ${PN}     \
    ${PN}-dbg \
    ${PN}-dev \
"
