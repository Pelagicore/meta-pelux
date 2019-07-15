FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Upstream pr: https://github.com/GENIVI/persistence-common-object/pull/7
SRC_URI += "file://0001-Partial-revert-of-3b28999fa9a1f7f8cd9b55ba6f8165e244.patch"
