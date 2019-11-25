SUMMARY = "Music server with MPD and Spotify support"
HOMEPAGE = "https://www.mopidy.com/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI[md5sum] = "519287f2ed8698b0018fbf07b35e0e4e"
SRC_URI[sha256sum] = "d1ee47fd91ae7ce2bf99cf85ed9108ac48c3fb5f29b31c7fbe94fac45c6e4a0b"

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
    python-tornado \
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
