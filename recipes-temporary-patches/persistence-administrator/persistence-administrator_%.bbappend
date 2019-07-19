FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Make-snprintf-comply-with-Werror-format-security.patch"

# Upstream pr: https://github.com/GENIVI/persistence-administrator/pull/6
SRC_URI += "file://0002-Replace-unknown-oip-cpi-mandatory.target-in-systemd-.patch"
