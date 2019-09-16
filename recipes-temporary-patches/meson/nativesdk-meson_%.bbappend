FILESEXTRAPATHS_prepend := "${THISDIR}/meson:"

# Yocto bug: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13508
# Meson pr: https://github.com/mesonbuild/meson/pull/5919
SRC_URI += "file://0001-dependencies-dev-use-sys.prefix-to-find-googletest-a.patch"
