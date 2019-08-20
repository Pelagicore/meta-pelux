SUMMARY = "Configures and controls systemd resources for PELUX"
DESCRIPTION = "This package supplies an extended set of systemd slice units \
and configures the services to be assigned to a given slice."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3e927855e47b22eecd81954b0f545a0f"

SRC_URI += " \
    file://LICENSE \
    file://connectivity.slice \
    file://ui.slice \
    file://service.neptune.conf \
"

S = "${WORKDIR}"

inherit allarch

do_install_append() {
    # Install slices
    install -d ${D}${systemd_unitdir}/system/

    install -m 0644 ${WORKDIR}/connectivity.slice ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ui.slice ${D}${systemd_unitdir}/system/

    # Install overrides for services
    install -d ${D}${systemd_unitdir}/system/neptune.service.d/
    install -m 0644 ${WORKDIR}/service.neptune.conf ${D}${systemd_unitdir}/system/neptune.service.d/
}

FILESEXTRAPATHS_prepend := "${THISDIR}/services/:"
FILESEXTRAPATHS_prepend := "${THISDIR}/slices/:"
FILESEXTRAPATHS_prepend := "${THISDIR}/systemd-resource-control/:"
FILES_${PN} += " \
    ${systemd_unitdir}/system/ \
    ${systemd_unitdir}/system/neptune.service.d/ \
"
