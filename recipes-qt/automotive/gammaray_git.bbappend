do_install_append() {
    chrpath -d ${D}${libdir}/libgammaray_core-qt5_10-x86_64.so.2.9.0
}
