SUMMARY = "Music server with MPD and Spotify support"
HOMEPAGE = "https://www.mopidy.com/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI[md5sum] = "ac41bb099309653b6a859daa32af30fb"
SRC_URI[sha256sum] = "297369a34ebd584b2fe25a7184f68fe876a149256549b03b503a55ede3f13f6a"

SRC_URI += "\
    file://0001-default.conf-Use-pulseaudio-as-default-output.patch \
    file://0002-local-ext.conf-Replace-XDG_MUSIC_DIR-with-a-hardcode.patch \
    file://mopidy.service \
    "

PYPI_PACKAGE = "Mopidy"
inherit pypi setuptools systemd

do_install_append() {
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

FILES_${PN} += "${systemd_system_unitdir}/mopidy.service"
SYSTEMD_SERVICE_${PN} = "mopidy.service"
