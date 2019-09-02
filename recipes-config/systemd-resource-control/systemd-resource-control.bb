SUMMARY = "Configures and controls systemd resources for PELUX"
DESCRIPTION = "This package supplies an extended set of systemd slice units \
and configures the services to be assigned to a given slice."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3e927855e47b22eecd81954b0f545a0f"

SRC_URI += " \
    file://LICENSE \
    file://connectivity.slice \
    file://ui.slice \
    file://service.bluetooth.conf \
    file://service.connectivity-manager.conf \
    file://service.connman.conf \
    file://service.neptune.conf \
    file://service.wpa_supplicant.conf \
"

S = "${WORKDIR}"

inherit allarch

do_install_append() {
    # Install slices
    install -d ${D}${systemd_unitdir}/system/

    install -m 0644 ${WORKDIR}/connectivity.slice ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ui.slice ${D}${systemd_unitdir}/system/

    # Install overrides for services
    install -d ${D}${systemd_unitdir}/system/bluetooth.service.d/
    install -d ${D}${systemd_unitdir}/system/connectivity-manager.service.d/
    install -d ${D}${systemd_unitdir}/system/connman.service.d/
    install -d ${D}${systemd_unitdir}/system/neptune.service.d/
    install -d ${D}${systemd_unitdir}/system/wpa_supplicant.service.d/

    install -m 0644 ${WORKDIR}/service.bluetooth.conf ${D}${systemd_unitdir}/system/bluetooth.service.d/
    install -m 0644 ${WORKDIR}/service.connectivity-manager.conf ${D}${systemd_unitdir}/system/connectivity-manager.service.d/
    install -m 0644 ${WORKDIR}/service.connman.conf ${D}${systemd_unitdir}/system/connman.service.d/
    install -m 0644 ${WORKDIR}/service.neptune.conf ${D}${systemd_unitdir}/system/neptune.service.d/
    install -m 0644 ${WORKDIR}/service.wpa_supplicant.conf ${D}${systemd_unitdir}/system/wpa_supplicant.service.d/
}

FILESEXTRAPATHS_prepend := "${THISDIR}/services/:"
FILESEXTRAPATHS_prepend := "${THISDIR}/slices/:"
FILESEXTRAPATHS_prepend := "${THISDIR}/systemd-resource-control/:"
FILES_${PN} += " \
    ${systemd_unitdir}/system/ \
    ${systemd_unitdir}/system/bluetooth.service.d/ \
    ${systemd_unitdir}/system/connectivity-manager.service.d/ \
    ${systemd_unitdir}/system/connman.service.d/ \
    ${systemd_unitdir}/system/neptune.service.d/ \
    ${systemd_unitdir}/system/wpa_supplicant.service.d/ \
"
