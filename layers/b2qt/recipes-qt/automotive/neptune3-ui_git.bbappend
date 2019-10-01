#
#   Copyright (C) 2017 Pelagicore AB
#   Coprright (C) 2018-2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://pelux.conf \
    file://neptune \
"

HAS_CONTAINMENT = "${@bb.utils.contains('DISTRO_FEATURES', 'process-containment', '-c /opt/am/sc-config.yaml', '', d)}"
FORCE_SINGLE_PROCESS = "${@bb.utils.contains('MACHINE', 'raspberrypi3', ' --force-single-process', '', d)}"

# Add software-container AM config to appman cmdline if we have containment support
# Also check out assets stored at Git LFS
do_install_prepend() {
    cd ${WORKDIR}/git/
    git lfs pull
    cd -
}

# If we are installing on a rpi3, we need to force wayland to use the broadcom
# driver when starting appman with neptune.
do_install_prepend_rpi() {
    ENV_LINE="QT_WAYLAND_HARDWARE_INTEGRATION=brcm"
    if ! grep -q "$ENV_LINE" "${WORKDIR}/neptune"; then
        sed -e "\$a$ENV_LINE" ${WORKDIR}/neptune
    fi
}

do_install_append() {
    install -d ${D}${sysconfdir}/default/
    install -d ${D}${systemd_system_unitdir}/neptune.service.d/

    install -m 0644 ${WORKDIR}/neptune ${D}${sysconfdir}/default/

    sed -i -e "s|\$EXTRA_ARGUMENTS|${HAS_CONTAINMENT}${FORCE_SINGLE_PROCESS}|" ${WORKDIR}/pelux.conf
    install -m 0644 ${WORKDIR}/pelux.conf ${D}${systemd_system_unitdir}/neptune.service.d/
}

RDEPENDS_${PN} += " qtquickcontrols-qmlplugins "

FILES_${PN} += "\
    ${sysconfdir}/default/ \
    ${systemd_unitdir}/system/neptune.service.d/pelux.conf \
"

FILES_${PN}-tests += "${datadir}/qt5/tests/neptune-qmltestsrunner/neptune-qmltestsrunner"
PACKAGES =+ "${PN}-tests"
