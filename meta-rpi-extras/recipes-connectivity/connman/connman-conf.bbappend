FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://settings"

do_install_append() {
    install -d ${D}/${localstatedir}/lib/connman
    install -m 0644 ${WORKDIR}/settings ${D}/${localstatedir}/lib/connman/settings
}
