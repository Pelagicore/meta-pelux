FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI +=  "\
    file://0001-udev-extraconf-allow-labels-and-UUID-s-in-mount-blac.patch;striplevel=5 \
    file://0002-udev-extraconf-do-not-try-to-mount-swap-partitions.patch;striplevel=5 \
    file://pelux-roots.blacklist \
"

RDEPENDS_${PN}_append = " util-linux-lsblk"

do_install_append() {
    install -m 0644 ${WORKDIR}/pelux-roots.blacklist ${D}${sysconfdir}/udev/mount.blacklist.d

    # Only want mount parts of udev-extraconf.
    rm ${D}${sysconfdir}/udev/rules.d/autonet.rules
    rm ${D}${sysconfdir}/udev/rules.d/localextra.rules
    rm ${D}${sysconfdir}/udev/scripts/network.sh
}

