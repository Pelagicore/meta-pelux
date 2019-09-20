FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://99-printk.conf"

do_install_append() {
    # Make sure resolv.conf is using systemd-resolved
    ln -s /run/systemd/resolve/resolv.conf ${D}${sysconfdir}/resolv.conf
}

FILES_${PN} += " \
    ${sysconfdir}/resolv.conf \
    ${libdir}/sysctl.d/99-printk.conf \
"

PACKAGECONFIG_remove = " \
    networkd \
"

do_install_append() {
    install -d ${D}${libdir}/sysctl.d
    install -m 0644 ${WORKDIR}/99-printk.conf ${D}${libdir}/sysctl.d/
}
