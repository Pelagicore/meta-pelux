SUMMARY = "A set of systemd slice units for PELUX"
DESCRIPTION = "This package supplies a set of generic systemd slice units that \
can be used by different services in PELUX."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3e927855e47b22eecd81954b0f545a0f"

SRC_URI += " \
    file://LICENSE \
    file://connectivity.slice \
    file://ui.slice \
"

S = "${WORKDIR}"

inherit allarch

do_install_append() {
    install -d ${D}${systemd_unitdir}/system/

    install -m 0644 ${WORKDIR}/connectivity.slice ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ui.slice ${D}${systemd_unitdir}/system/
}

FILESEXTRAPATHS_prepend := "${THISDIR}/slices/:"
FILESEXTRAPATHS_prepend := "${THISDIR}/systemd-resource-control/:"
FILES_${PN} += " \
    ${systemd_unitdir}/system/ \
"
