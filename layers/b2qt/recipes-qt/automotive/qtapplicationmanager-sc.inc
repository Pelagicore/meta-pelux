#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

RDEPENDS_${PN} += "${PN}-softwarecontainer"

# Due to immediate expansion of variables using :=, ${PN} is not yet available
# in this .inc-file
FILESEXTRAPATHS_prepend := "${THISDIR}/qtapplicationmanager:"

EXTRA_QMAKEVARS_PRE += "\
    -config enable-examples \
"

SRC_URI += " \
    file://sc-config.yaml \
    "

do_install_append_class-target() {
    install -d ${D}${libdir}
    install -m 755 ${B}/examples/softwarecontainer-plugin/libsoftwarecontainer-plugin.so ${D}/usr/lib/
    install ${WORKDIR}/sc-config.yaml ${D}/opt/am/
}

FILES_SOLIBSDEV = ""
PACKAGES =+ "${PN}-softwarecontainer"
FILES_${PN}-softwarecontainer = "\
	${libdir}/libsoftwarecontainer-plugin.so \
	"
