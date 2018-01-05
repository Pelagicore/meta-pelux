#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

# Bump SRCREV to use same as pyro, license file has changed hash and install dir is different
SRCREV = "6ddea70fd06d78ca7672f18221b91b3e8990aee8"
LIC_FILES_CHKSUM = "file://LICENSE.GPL3;md5=bc0cb4bfd3f72b3fe47b2b2d0d89762c"
FILES_${PN}-apps += "/opt/neptune/apps"
FILES_${PN} += "/opt/neptune"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append = "\
      dbus-session       \
      qtwebengine        \
      qtquickcontrols2   \
      "

HAS_CONTAINMENT = "${@bb.utils.contains('DISTRO_FEATURES', 'process-containment', '-c /opt/am/sc-config.yaml', '', d)}"

#
# Add software-container AM config to appman cmdline if we have containment
# support
#
do_install_prepend() {
    sed -i -e "s|\$EXTRA_ARGUMENTS|${HAS_CONTAINMENT}|" ${WORKDIR}/neptune.service
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
