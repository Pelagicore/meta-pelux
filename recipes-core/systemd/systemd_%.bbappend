
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# This sets up a default ethernet on DHCP
SRC_URI += "file://10-pelux-ethernet.network"

# We also make sure resolv.conf is using systemd-resolved
do_install_append() {
    install -m 0644 ${WORKDIR}/10-pelux-ethernet.network ${D}${sysconfdir}/systemd/network/10-pelux-ethernet.network
    ln -s /run/systemd/resolve/resolv.conf ${D}${sysconfdir}/resolv.conf
}
