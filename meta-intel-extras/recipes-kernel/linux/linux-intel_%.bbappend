#
#   Copyright (C) 2016 Pelagicore AB
#   Copyright (C) 2018-2019 Luxoft Sweden AB
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

KERNEL_FEATURES_append = " features/mmc/mmc-realtek.scc"

# Additional config fragments
SRC_URI += " \
    file://enable-can.cfg \
    file://enable-veth.cfg \
    file://enable-hid-multitouch.cfg \
"
