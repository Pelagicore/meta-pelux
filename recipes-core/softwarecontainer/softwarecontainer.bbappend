#
# Copyright Pelagicore 2017
#
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://io.qt.ApplicationManager.Application.json \
    file://softwarecontainer-agent.service \
    "

do_install_append(){
    install ${WORKDIR}/io.qt.ApplicationManager.Application.json ${D}/etc/softwarecontainer/service-manifest.d/
    install ${WORKDIR}/softwarecontainer-agent.service ${D}/lib/systemd/system/
}
