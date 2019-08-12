FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Upstream pr: https://github.com/GENIVI/persistence-administrator/pull/6
SRC_URI += "file://0002-Replace-unknown-oip-cpi-mandatory.target-in-systemd-.patch"
