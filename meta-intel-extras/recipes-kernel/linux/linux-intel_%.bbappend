#
#   Copyright (C) 2016 Pelagicore AB
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
# Additional config fragments
SRC_URI += " \
    file://enable-veth.cfg \
    file://enable-hid-multitouch.cfg \
"
