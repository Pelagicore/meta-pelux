FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://0001-Don-t-try-to-build-the-ivigenerator-autotests-when-t.patch"

PACKAGECONFIG_remove = "ivigenerator"
PACKAGECONFIG_remove = "ivigenerator-native"
