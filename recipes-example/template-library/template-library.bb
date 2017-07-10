#
#   Copyright (C) 2017 Pelagicore AB
#

SUMMARY = "A template C/C++ library"
DESCRIPTION = "A C/C++ shared library blueprint"
AUTHOR = "Gordan Markuš <gordan.markus@pelagicore.com>"
HOMEPAGE = "https://github.com/Pelagicore/template-library"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"
PV = "1.0+git${SRCREV}"
PR = "r0"

SRCREV = "29d6dbd859d725ee6d10686ee5449069412de2c6"
SRC_URI = "git://github.com/Pelagicore/template-library.git;protocol=https;branch=master"

S = "${WORKDIR}/git/"

inherit cmake pkgconfig

PACKAGES = " \
    ${PN}     \
    ${PN}-dbg \
    ${PN}-dev \
"

FILES_${PN} += " \
    ${libdir}/libtemplate-library.so \
"
