# This config loads the native-protocol-tcp module if available
# It also installs a system service running a system-wide pulseaudio

inherit systemd

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/:"

SRC_URI += "\
    file://system.pa \
    file://pulseaudio.service \
    "

do_install_append() {
    install -m 0644 ${WORKDIR}/system.pa ${D}/${sysconfdir}/pulse/

    install -d ${D}/${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/pulseaudio.service ${D}/${systemd_system_unitdir}
}

FILES_${PN}-server += "${systemd_system_unitdir}/pulseaudio.service"
SYSTEMD_PACKAGES = "${PN}-server"
SYSTEMD_SERVICE_${PN}-server = "pulseaudio.service"
