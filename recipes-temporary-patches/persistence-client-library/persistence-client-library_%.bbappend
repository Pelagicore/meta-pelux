FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Upstream pr: https://github.com/GENIVI/persistence-client-library/pull/16
SRC_URI += "file://0001-Remove-D-Bus-policy-configuration-for-org.genivi.per.patch"

# Upstream pr: https://github.com/GENIVI/meta-ivi/pull/111
RDEPENDS_${PN}_append = " persistence-administrator"
