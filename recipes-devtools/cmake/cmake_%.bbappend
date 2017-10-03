FILESEXTRAPATHS_prepend := "${THISDIR}/cmake:"

SRC_URI_append_class-nativesdk = "\
    file://StagingPrefix.cmake \
"

do_install_append_class-nativesdk() {
    # Install CMake's toolchain configuration
    mkdir -p ${D}${datadir}/cmake/OEToolchainConfig.cmake.d/
    install -m 644 ${WORKDIR}/StagingPrefix.cmake ${D}${datadir}/cmake/OEToolchainConfig.cmake.d/
}
