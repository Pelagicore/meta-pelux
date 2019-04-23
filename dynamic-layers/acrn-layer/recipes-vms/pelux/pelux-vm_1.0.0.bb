# Copyright (C) 2019 Luxoft Sweden AB
# Released under the MIT license (see LICENSE for the terms)

DESCRIPTION = "Script that starts a PELUX-VM"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3da9cfbcb788c80a0384361b4de20420"

RDEPENDS_${PN} = "acrn-vm-targets acrn-vm-init bash"

inherit systemd

S = "${WORKDIR}"

SRC_URI = "                 \
    file://LICENSE          \
    file://launch_pelux.sh  \
    file://pelux-vm.service \
    "

FILES_${PN} = "               \
    ${datadir}/acrn/scripts/* \
    ${systemd_system_unitdir}/*          \
    ${datadir}/acrn/images/linux/pelux.img \
    ${datadir}/acrn/images/linux/bzImage \
    "

SYSTEMD_SERVICE_${PN} = "pelux-vm.service"


PELUX_IMAGE ?= "core-image-pelux-minimal"

do_install[mcdepends] = "multiconfig:sos:uos:${PELUX_IMAGE}:do_image_complete"

do_install_append() {
    install -D -m 0755 ${S}/launch_pelux.sh ${D}${datadir}/acrn/scripts/launch_pelux.sh
    install -D -m 0755 ${S}/pelux-vm.service ${D}${systemd_system_unitdir}/pelux-vm.service

    install -D -m 0644 ${TOPDIR}/tmpuos/deploy/images/${MACHINE}/${PELUX_IMAGE}-${MACHINE}.wic \
                       ${D}${datadir}/acrn/images/linux/pelux.img
    install -D -m 0644 ${TOPDIR}/tmpuos/deploy/images/${MACHINE}/bzImage \
                       ${D}${datadir}/acrn/images/linux/bzImage
}
