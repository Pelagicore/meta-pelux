SUMMARY = "Music server with MPD and Spotify support"
HOMEPAGE = "https://www.mopidy.com/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI[md5sum] = "e791afa0e4a1926963433c8c5f3be63b"
SRC_URI[sha256sum] = "361913efcb97afc18752d1ebce688f120955a19dae2e9a2b5c29aa6d20044fbf"

SRC_URI += "\
    file://0001-default.conf-Use-pulseaudio-as-default-output.patch \
    file://0002-local-ext.conf-Replace-XDG_MUSIC_DIR-with-a-hardcode.patch \
    file://mopidy.service \
    "

inherit pypi setuptools systemd useradd

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

PYPI_PACKAGE = "Mopidy"

# Create user and group
USER = "mopidy"
GROUP = "mopidy"
USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = "--no-create-home --gid ${GROUP} --shell /bin/false ${USER}"
GROUPADD_PARAM_${PN} = "${GROUP}"

SYSTEMD_SERVICE_${PN} = "mopidy.service"
