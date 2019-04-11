# Copyright (C) 2019 Luxoft Sweden AB
# Released under the MIT license (see LICENSE for the terms)

DESCRIPTION = "Systemd targets for starting ACRN VMs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=dd98d01d471fac8d8dbdd975229dba03"

RDEPENDS_${PN} = "acrn-vm-init"

inherit systemd

S = "${WORKDIR}"

SRC_URI = "                \
    file://LICENSE         \
    file://acrn-vm1.target \
    file://acrn-vm2.target \
    file://acrn-vm3.target \
    "

FILES_${PN} = "               \
    ${systemd_system_unitdir}/acrn-vm1.target  \
    ${systemd_system_unitdir}/acrn-vm2.target  \
    ${systemd_system_unitdir}/acrn-vm3.target  \
    "

SYSTEMD_SERVICE_${PN} = "acrn-vm1.target"

do_install_append() {
    install -D -m 0755 ${S}/acrn-vm1.target ${D}${systemd_system_unitdir}/acrn-vm1.target
    install -D -m 0755 ${S}/acrn-vm2.target ${D}${systemd_system_unitdir}/acrn-vm2.target
    install -D -m 0755 ${S}/acrn-vm3.target ${D}${systemd_system_unitdir}/acrn-vm3.target
}
