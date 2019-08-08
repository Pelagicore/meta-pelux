FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://99-printk.conf"

do_install_append() {
    # Make sure resolv.conf is using systemd-resolved
    ln -s /run/systemd/resolve/resolv.conf ${D}${sysconfdir}/resolv.conf

    # Create mutiple consoles
    tmp="${TTY_LIST}"
    for ttydev in $tmp ; do
        ln -sf ${systemd_unitdir}/system/getty@.service ${D}${sysconfdir}/systemd/system/getty.target.wants/getty@$ttydev.service
    done
}

FILES_${PN} += "/etc/resolv.conf"
FILES_${PN} += "${sysconfdir}/systemd/system/getty.target.wants"
FILES_${PN} += "${libdir}/sysctl.d/99-printk.conf"

PACKAGECONFIG_append = " kmod "

do_install_append() {
    install -d ${D}${libdir}/sysctl.d
    install -m 0644 ${WORKDIR}/99-printk.conf ${D}${libdir}/sysctl.d/
}
