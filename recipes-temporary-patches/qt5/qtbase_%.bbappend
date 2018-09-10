# CMake files may end up containing paths to STAGING_DIR_HOST. Problematic since
# STAGING_DIR_HOST is not quaranteed to exist throughout the build (or at all if
# sstate-cache is used...?).
#
# Caused intermittent build failuers when building GammaRay for Raspberry Pi
# since GammaRay uses the Qt5::Gui_GLESv2 target in
# gammaray/plugins/quickinspector/CMakeLists.txt. meta-boot2qt sets
# QMAKE_INCDIR_EGL to extra include directories needed for the VC driver which
# are in turn added to Qt5::Gui_GLESv2 in qtbase. CMake fails when a target has
# include directories that do not exist.
#
# Filed https://github.com/meta-qt5/meta-qt5/issues/108 for getting this fixed
# upstream.
do_install_append() {
    find ${D}${libdir}/cmake -name "*.cmake" | while read f; do
        sed -i "$f" -e "s@${STAGING_DIR_HOST}/@\$ENV{PKG_CONFIG_SYSROOT_DIR}/@g"
    done
}
