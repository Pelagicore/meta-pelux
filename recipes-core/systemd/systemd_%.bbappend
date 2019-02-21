FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# This sets up a default ethernet on DHCP
SRC_URI += "file://10-pelux-ethernet.network"

# We also make sure resolv.conf is using systemd-resolved
do_install_append() {
    install -m 0644 ${WORKDIR}/10-pelux-ethernet.network ${D}${sysconfdir}/systemd/network/10-pelux-ethernet.network
    if [ ! -z "${STATIC_IP_ADDRESS}" ]; then
    	echo "[Address]" >> ${D}${sysconfdir}/systemd/network/10-pelux-ethernet.network
    	echo "Address=${STATIC_IP_ADDRESS}/24" >> ${D}${sysconfdir}/systemd/network/10-pelux-ethernet.network
    fi
    ln -s /run/systemd/resolve/resolv.conf ${D}${sysconfdir}/resolv.conf

    # Create mutiple consoles
    tmp="${TTY_LIST}"
    for ttydev in $tmp ; do
        ln -sf ${systemd_unitdir}/system/getty@.service ${D}${sysconfdir}/systemd/system/getty.target.wants/getty@$ttydev.service
    done
}

EXTRA_OECONF = "myhostname"

FILES_${PN} += "/etc/resolv.conf"
FILES_${PN} += "${sysconfdir}/systemd/system/getty.target.wants"
