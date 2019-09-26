FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://psplash-start.service \
    file://psplash-stop.service \
"

inherit systemd

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${PN}', '', d)}"
SYSTEMD_SERVICE_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' psplash-start.service psplash-stop.service', '', d)}"

do_install_append () {
    install -d ${D}${systemd_system_unitdir}
    install -m 644 ${WORKDIR}/psplash-start.service ${D}${systemd_system_unitdir}
    install -m 644 ${WORKDIR}/psplash-stop.service ${D}${systemd_system_unitdir}
}
