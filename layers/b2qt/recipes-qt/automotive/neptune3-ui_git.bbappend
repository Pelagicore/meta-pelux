#
#   Copyright (C) 2017 Pelagicore AB
#   Coprright (C) 2018-2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append = "\
    dbus-session \
    otf-noto-arabic \
"

HAS_CONTAINMENT = "${@bb.utils.contains('DISTRO_FEATURES', 'process-containment', '-c /opt/am/sc-config.yaml', '', d)}"
FORCE_SINGLE_PROCESS = "${@bb.utils.contains('MACHINE', 'raspberrypi3', ' --force-single-process', '', d)}"

#
# Add software-container AM config to appman cmdline if we have containment support
# Also check out assets stored at Git LFS
#
do_install_prepend() {
    cd ${WORKDIR}/git/
    git lfs pull
    cd -

    sed -i -e "s|\$EXTRA_ARGUMENTS|${HAS_CONTAINMENT}${FORCE_SINGLE_PROCESS}|" ${WORKDIR}/neptune.service
}

#
# If we are installing on a rpi3, we need to force wayland to use the broadcom
# driver when starting appman with neptune.
#
do_install_prepend_rpi() {
    ENV_LINE="Environment=QT_WAYLAND_HARDWARE_INTEGRATION=brcm"
    if ! grep -q "$ENV_LINE" "${WORKDIR}/neptune.service"; then
        sed -i -e "/^\[Install\]$/i $ENV_LINE" ${WORKDIR}/neptune.service
    fi
}

RDEPENDS_${PN} += " qtquickcontrols-qmlplugins "

FILES_${PN}-tests += "${datadir}/qt5/tests/neptune-qmltestsrunner/neptune-qmltestsrunner"
PACKAGES =+ "${PN}-tests"
