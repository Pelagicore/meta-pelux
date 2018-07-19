inherit systemd

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/:"

SRC_URI += "\
    file://grubenv \
    file://grubenv-copy.sh \
    file://grubenv-copy.service\
"

do_install_append() {
    install -d ${D}${datadir}
    install -m 0755 ${WORKDIR}/grubenv ${D}${datadir}

    install -m 0755 ${WORKDIR}/grubenv-copy.sh ${D}${bindir}

    install -d ${D}${systemd_system_unitdir}
    install -m 0755 ${WORKDIR}/grubenv-copy.service ${D}${systemd_system_unitdir}
}

FILES_${PN} += " \
    ${datadir}/grubenv \
    ${bindir}/grubenv-copy.sh \
    ${systemd_system_unitdir}/grubenv-copy.service \
"

SYSTEMD_SERVICE_${PN} = "grubenv-copy.service"
