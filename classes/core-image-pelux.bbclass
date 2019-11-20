#
#   Copyright (C) 2017 Pelagicore AB
#   Copyright (C) 2018-2019 Luxoft Sweden AB
#   SPDX-License-Identifier: MIT
#

inherit core-image

IMAGE_FEATURES_append = " package-management debug-tweaks"

IMAGE_INSTALL_append = "\
    ${@bb.utils.contains("COMBINED_FEATURES", "bluetooth", "packagegroup-tools-bluetooth", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "process-containment", "softwarecontainer", "", d)} \
    swupdate \
    udev-extraconf \
"

# We do not support swupdate on qemu
IMAGE_INSTALL_remove_qemux86-64 = "\
    swupdate \
"

# swupdate does not compile on smarcimx8m2g
IMAGE_INSTALL_remove_smarcimx8m2g = "\
    swupdate \
"

# swupdate and avs-device-sdk do not compile on jetson-tx2
IMAGE_INSTALL_remove_jetson-tx2 = "\
    swupdate \
    avs-device-sdk \
"

# GENIVI components
IMAGE_INSTALL_append = "\
    dlt-daemon         \
    dlt-daemon-systemd \
    node-state-manager \
"

# Should probably be included in some other way (dependency, package group, feature).
IMAGE_INSTALL_append = "\
    avs-device-sdk     \
    can-utils \
    connectivity-manager \
    iproute2 \
    libsocketcan \
    mopidy \
    systemd-resource-control \
    user-identification-manager \
"

TOOLCHAIN_HOST_TASK += "\
    nativesdk-cmake \
    nativesdk-gdbus-codegen-glibmm \
    nativesdk-meson \
"

#
# INTEL
#

IMAGE_INSTALL_append_intel-corei7-64 = " grub-efi"

#
# JETSON
#

IMAGE_INSTALL_append_jetson-tx2 = " kernel-modules"

#
# QEMU
#

# Enable testing
INHERIT_qemux86-64 += " \
    testimage \
    testexport \
"

# All test suites to run
TEST_SUITES_qemux86-64 = " \
    date \
    ping \
    ssh \
    scp \
    df \
    parselogs \
    softwarecontainer \
    node_state_manager \
    dlt_daemon \
    systemd.SystemdBasicTests.test_systemd_basic \
    systemd.SystemdBasicTests.test_systemd_failed \
    systemd.SystemdBasicTests.test_systemd_list \
    systemd.SystemdJournalTests.test_systemd_journal \
    rpm.RpmBasicTest \
    rpm.RpmInstallRemoveTest.test_rpm_install \
    rpm.RpmInstallRemoveTest.test_rpm_query_nonroot \
    rpm.RpmInstallRemoveTest.test_rpm_remove \
"

#
# IMX8
# A less specific machine might be available and preferable
#

# networkmanager conflicts with connman
MACHINE_EXTRA_RDEPENDS_remove_smarcimx8m2g = "networkmanager"
