FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI += " \
     file://swupdate.cfg \
     file://swupdate.service \
     "

do_install_append() {
    sed -i -e "s|\$UPDATE_TARGET|${MACHINE}|" ${WORKDIR}/swupdate.service

    install -d ${D}${sysconfdir}
    install -d ${D}${systemd_unitdir}/system

    install -m 644 ${WORKDIR}/swupdate.cfg ${D}${sysconfdir}
    install -m 644 ${WORKDIR}/swupdate.service ${D}${systemd_unitdir}/system

    rm -rf ${D}${systemd_unitdir}/system/swupdate-usb@.service
    rm -rf ${D}${systemd_unitdir}/system/swupdate-progress.service
}

SYSTEMD_SERVICE_${PN}_remove = "swupdate-usb@.service swupdate-progress.service"

SYSTEMD_AUTO_ENABLE_${PN} = "disable"
