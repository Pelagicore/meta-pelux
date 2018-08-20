#
#   Copyright (C) 2016 Pelagicore AB
#   Copyright (C) 2018 Luxoft Sweden AB
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Additional config fragments
SRC_URI += " \
    file://enable-can.cfg \
    file://enable-cgroup_bpf.cfg \
    file://enable-veth.cfg \
    file://enable-hid-multitouch.cfg \
"
