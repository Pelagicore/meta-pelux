
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://powerbtn \
    file://powerbtn.sh \
"

do_install_append() {
    install -m 0755 ${WORKDIR}/powerbtn.sh ${D}${sysconfdir}/acpi/powerbtn.sh
    install -m 0644 ${WORKDIR}/powerbtn ${D}${sysconfdir}/acpi/events/powerbtn
}
