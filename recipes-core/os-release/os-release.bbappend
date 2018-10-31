VERSION = "${DISTRO_VERSION}${@' (Based on Yocto %s)' % DISTRO_CODENAME if 'DISTRO_CODENAME' in d else ''}"
