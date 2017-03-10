#
# Copyright Pelagicore 2017
#

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append = "\
      dbus-session       \
      "
