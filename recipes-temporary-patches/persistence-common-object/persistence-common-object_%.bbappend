FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Upstream pr: https://github.com/GENIVI/persistence-common-object/pull/7
SRC_URI += "file://0001-Partial-revert-of-3b28999fa9a1f7f8cd9b55ba6f8165e244.patch"

# Upstream pr: https://github.com/GENIVI/persistence-common-object/pull/8
SRC_URI += "\
    file://0002-Revert-dbus_config-Remove-dbus-configuration-file.patch \
    file://0003-Install-D-Bus-policy-file-in-usr-share-dbus-1-system.patch \
"
