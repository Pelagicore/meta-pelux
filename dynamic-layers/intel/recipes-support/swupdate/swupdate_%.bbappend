FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

RDEPENDS_${PN} += "parted util-linux-sfdisk"
