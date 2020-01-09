FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://change_background_color.patch \
    file://disable_progress_bar.patch \
    file://Draw-splash-in-the-middle-of-the-screen.patch \
    file://psplash-start.service \
    file://psplash-stop.service \
"

SPLASH_IMAGES_append = " file://pelux_logo-img.h;outsuffix=pelux"

ALTERNATIVE_PRIORITY_psplash-pelux[psplash] = "900"

inherit systemd

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${PN}', '', d)}"
SYSTEMD_SERVICE_${PN}_append = "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', ' psplash-start.service psplash-stop.service', '', d)}"

do_install_append () {
    install -d ${D}${systemd_system_unitdir}
    install -m 644 ${WORKDIR}/psplash-start.service ${D}${systemd_system_unitdir}
    install -m 644 ${WORKDIR}/psplash-stop.service ${D}${systemd_system_unitdir}
}
