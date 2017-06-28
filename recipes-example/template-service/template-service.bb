#
#   Copyright (C) 2017 Pelagicore AB
#

DESCRIPTION = "A template C/C++ service"
HOMEPAGE = "https://github.com/Pelagicore/template-service"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

PR = "r0"
PV = "1.0+git${SRCREV}"

SRC_URI = "git://github.com/Pelagicore/template-service.git;protocol=https;branch=master"

SRCREV = "5bce3d20f996dac7e3882f48f5057abb7e1d05f5"

inherit cmake pkgconfig

DEPENDS = "template-library"

S = "${WORKDIR}/git/"

PACKAGES = " \
    ${PN}     \
    ${PN}-dbg \
    ${PN}-dev \
"
