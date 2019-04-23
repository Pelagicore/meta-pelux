# Copyright (C) 2019 Luxoft Sweden AB
# Released under the MIT license (see LICENSE for the terms)

DESCRIPTION = "Systemd targets for starting ACRN VMs"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=dd98d01d471fac8d8dbdd975229dba03"

inherit systemd

S = "${WORKDIR}"

SRC_URI = "                \
    file://LICENSE         \
    file://acrn-vm-init.service \
    file://acrn-vm-init.sh \
    "

FILES_${PN} = "                                    \
    ${datadir}/acrn/scripts/acrn-vm-init.sh        \
    ${systemd_system_unitdir}/acrn-init-vm.service \
    "

SYSTEMD_SERVICE_${PN} = "acrn-vm-init.service"

do_install_append() {
    install -D -m 0755 ${S}/acrn-vm-init.sh ${D}${datadir}/acrn/scripts/acrn-vm-init.sh
    install -D -m 0644 ${S}/acrn-vm-init.service ${D}${systemd_system_unitdir}/acrn-vm-init.service
}
