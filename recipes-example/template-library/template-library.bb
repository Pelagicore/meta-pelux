#
#   Copyright (C) 2017 Pelagicore AB
#

DESCRIPTION = "A template C/C++ library"
HOMEPAGE = "https://github.com/Pelagicore/template-library"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

PR = "r0"
PV = "1.0+git${SRCREV}"

SRC_URI = "git://github.com/Pelagicore/template-library.git;protocol=https;branch=master"

SRCREV = "29d6dbd859d725ee6d10686ee5449069412de2c6"

inherit cmake pkgconfig

S = "${WORKDIR}/git/"

PACKAGES = " \
    ${PN}     \
    ${PN}-dbg \
    ${PN}-dev \
"

FILES_${PN} += " \
    ${libdir}/libtemplate-library.so \
"
