FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

RDEPENDS_${PN} += "parted util-linux-sfdisk u-boot-fw-utils"
