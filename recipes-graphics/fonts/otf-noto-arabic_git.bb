SUMMARY = "Noto Sans Arabic"
SECTION = "fonts"
HOMEPAGE = "https://www.google.com/get/noto/"
LICENSE = "OFL-1.1"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=fce5baa9b16328f04e2afc29f6e4e882"

SRC_URI = "git://github.com/googlei18n/noto-fonts.git;protocol=https"
SRCREV = "4bff97c612daf65d4409c9ebc26dfbd6a3d83a7e"

INHIBIT_DEFAULT_DEPS = "1"

inherit allarch fontcache

S = "${WORKDIR}/git"

do_install() {
    install -m 0755 -d ${D}${datadir}/fonts/otf/noto
    install -m 0644 ${S}/hinted/NotoSansArabic-Regular.ttf ${D}${datadir}/fonts/otf/noto
}

PACKAGES = "${PN}"
FILES_${PN} += "${datadir}/fonts/otf/noto"
