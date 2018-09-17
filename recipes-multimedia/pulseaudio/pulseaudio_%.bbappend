# This config loads the native-protocol-tcp module if available

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/:"

SRC_URI += "\
    file://system.pa \
    "

do_install_append() {
    install -m 0644 ${WORKDIR}/system.pa ${D}/${sysconfdir}/pulse/
}

FILES_${PN}-server += "${systemd_system_unitdir}/pulseaudio.service"
