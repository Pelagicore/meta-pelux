SUMMARY = "Qt IVI Mopidy media playback plugin"
HOMEPAGE = "https://github.com/Pelagicore/qtivi-qtivi-plugin"
SECTION = "libs/multimedia"
LICENSE = "LGPL-3.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3000208d539ec061b899bce1d9ce9404"

DEPENDS = "qtbase qtwebsockets qtivi"
RDEPENDS_${PN} = "qtivi"

SRC_URI = "git://github.com/Pelagicore/qtivi-mopidy-plugin.git;protocol=https"
SRCREV = "538a7ba9940e13a4028c5258a8ace5693429e1c9"

S = "${WORKDIR}/git"

inherit qmake5

do_install() {
    install -m 0755 -d ${D}${libdir}/plugins/qtivi/
    install -m 0644 ${WORKDIR}/build/libmedia_mopidy.so ${D}${libdir}/plugins/qtivi/
}

FILES_${PN} += "${libdir}/plugins/qtivi/"
