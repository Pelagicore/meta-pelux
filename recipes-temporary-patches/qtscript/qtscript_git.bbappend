FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://lto.patch"

EXTRA_QMAKEVARS_PRE_append_arm = " CONFIG-=ltcg"
