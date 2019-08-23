#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://io.qt.ApplicationManager.Application.json \
    file://softwarecontainer-agent.service \
    "

do_install_append(){
    install ${WORKDIR}/io.qt.ApplicationManager.Application.json ${D}${sysconfdir}/softwarecontainer/service-manifest.d/
    install -m 0644 ${WORKDIR}/softwarecontainer-agent.service ${D}${systemd_unitdir}/system/
}
