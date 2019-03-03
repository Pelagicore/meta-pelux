SUMMARY = "Alexa Auto SDK"
HOMEPAGE = "http://github.com/alexa/aac-sdk"
SECTION = "libs"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI = "https://github.com/alexa/aac-sdk/archive/v${PV}.tar.gz"
SRC_URI[md5sum] = "104fb98572def291f60dc95a5fb1eb77"
SRC_URI[sha256sum] = "6dc631d194527a368ebd9916c7f2958f5d4d707d3d8ea0396bbd157f3f18d084"

DEPENDS = "avs-device-sdk gtest"
RDEPENDS_${PN} = "avs-device-sdk"

inherit cmake pkgconfig

S = "${WORKDIR}/aac-sdk-${PV}"

FILES_SOLIBSDEV = ""
SOLIBS = ".so"
