#
#   Copyright (C) 2016 Pelagicore AB
#   Copyright (C) 2018 Luxoft Sweden AB
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
# Additional config fragments
SRC_URI += " \
    file://enable-veth.cfg \
    file://enable-hid-multitouch.cfg \
"

LINUX_VERSION = "4.9.116"
KBRANCH = "4.9/yocto/base"
SRCREV_machine = "521a610f0eab91e6f8c36c88916338e2cb36aa1c"
