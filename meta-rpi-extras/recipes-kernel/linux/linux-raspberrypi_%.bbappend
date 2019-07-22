FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://usb_functionfs.cfg"

CMDLINE_append = "cgroup_enable=memory"
