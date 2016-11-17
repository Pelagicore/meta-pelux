#
#   Copyright (C) 2015 Pelagicore AB
#
DESCRIPTION = "Image for creating a Pelux image"

inherit core-image

# Pelux components
IMAGE_INSTALL += "softwarecontainer"

# Network management
IMAGE_INSTALL += "connman"

# helpers (dev)
IMAGE_FEATURES += "package-management"

# systemd units
IMAGE_INSTALL += "systemd-additional-units"

# Include bluetooth if the machine supports it (MACHINE_FEATURES), and it has
# been selected in DISTRO_FEATURES.
IMAGE_INSTALL += "\
    ${@base_contains("COMBINED_FEATURES", "bluetooth", "packagegroup-tools-bluetooth", "", d)} \
"

TOOLCHAIN_HOST_TASK += "nativesdk-cmake"

# Add "/usr/lib/cmake" to the PATH variable so that CMake can find the *Config.cmake" when FIND_PACKAGE() is called from a CMake makefile
toolchain_create_sdk_env_script_append() {
  echo 'export PATH=$PATH:$SDKTARGETSYSROOT/usr/lib/cmake' >> $script
}

# No need for too much space right now, but some extra is always nice. 
IMAGE_ROOTFS_SIZE ?= "1000000"

IMAGE_FSTYPES ?= "ext3 sdcard"
