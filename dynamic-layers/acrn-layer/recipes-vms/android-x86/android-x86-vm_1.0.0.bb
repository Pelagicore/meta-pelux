# Copyright (C) 2019 Luxoft Sweden AB
# Released under the MIT license (see LICENSE for the terms)

DESCRIPTION = "Installs an android-x86 VM"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

DEPENDS = "squashfs-tools-native parted-native xorriso-native e2fsprogs-native"
RDEPENDS_${PN} = "acrn-vm-targets acrn-vm-init bash"

inherit systemd

S = "${WORKDIR}"

SRC_URI = "                 \
    file://LICENSE          \
    file://launch_android_x86.sh  \
    file://android-x86-vm.service \
    file://android-x86-uninstalled.iso \
    "

FILES_${PN} = "               \
    ${datadir}/acrn/scripts/* \
    ${systemd_system_unitdir}/*          \
    ${datadir}/acrn/images/android-x86/android.img \
    ${datadir}/acrn/images/android-x86/initrd.img \
    ${datadir}/acrn/images/android-x86/kernel \
    "

SYSTEMD_SERVICE_${PN} = "android-x86-vm.service"

do_compile() {

    cd ${WORKDIR}

    for file_to_extract in system.sfs ramdisk.img initrd.img kernel
    do
        xorriso -osirrox on -indev android-x86-uninstalled.iso -extract $file_to_extract ${WORKDIR}/$file_to_extract
    done

    # Allocating disk image...
    SIZE_M=3500
    dd if=/dev/zero of=android.img bs=1M count=0 seek=$SIZE_M

    # Partitioning...
    parted android.img mklabel msdos --script
    # Creating ext4 FS...
    parted -a opt android.img mkpart primary ext4 0% 100% --script

    #Put the files (system.img, ramdisk.img) into the partition created.
    echo Repacking...

    IMG_MNT_DIR="${WORKDIR}/img_mnt"
    unsquashfs -d ${IMG_MNT_DIR} system.sfs
    cp ramdisk.img ${IMG_MNT_DIR}/ramdisk.img

    mkdir -p ${IMG_MNT_DIR}/data
    chmod 755 ${IMG_MNT_DIR}/data

    #Offset is the sector size * begining of the partition
    mkfs.ext4 -F -Eoffset=1048576 -d ${IMG_MNT_DIR} android.img

    rm -R ${IMG_MNT_DIR}
}

do_install_append() {
    install -D -m 0755 ${S}/launch_android_x86.sh ${D}${datadir}/acrn/scripts/launch_android_x86.sh
    install -D -m 0755 ${S}/android-x86-vm.service ${D}${systemd_system_unitdir}/android-x86-vm.service

    install -D -m 0644 ${WORKDIR}/initrd.img \
                       ${D}${datadir}/acrn/images/android-x86/initrd.img
    install -D -m 0644 ${WORKDIR}/android.img \
                       ${D}${datadir}/acrn/images/android-x86/android.img
    install -D -m 0644 ${WORKDIR}/kernel \
                       ${D}${datadir}/acrn/images/android-x86/kernel
}
