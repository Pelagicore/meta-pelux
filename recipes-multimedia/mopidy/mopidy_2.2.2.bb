SUMMARY = "Music server with MPD and Spotify support"
HOMEPAGE = "https://www.mopidy.com/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI[md5sum] = "62491cae99dd867556a3d3bba3309dde"
SRC_URI[sha256sum] = "b41f5ab1e83c5e5f74fdb792c8fd5ba63b7fd227d04df266dba5189bc552a93d"

SRC_URI += "\
    file://0001-default.conf-Use-pulseaudio-as-default-output.patch \
    file://0002-local-ext.conf-Replace-XDG_MUSIC_DIR-with-a-hardcode.patch \
    file://mopidy.service \
    "

PYPI_PACKAGE = "Mopidy"
inherit pypi setuptools systemd

do_install_append() {
    install -d ${D}/${ROOT_HOME}/Music
    install -d ${D}/${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/mopidy.service ${D}/${systemd_system_unitdir}
}

RDEPENDS_${PN} += "\
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-python \
    python-argparse \
    python-pygobject \
    python-pykka \
    python-requests \
    python-setuptools \
    python-tornado45 \
    python-xml \
    "

RRECOMMENDS_${PN} = "\
    pulseaudio-server \
    pulseaudio-module-native-protocol-tcp \
    "

FILES_${PN} += " \
    ${ROOT_HOME}/Music \
    ${systemd_system_unitdir}/mopidy.service \
    "

SYSTEMD_SERVICE_${PN} = "mopidy.service"
