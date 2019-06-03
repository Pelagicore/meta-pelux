#   Copyright (c) 2012-2019 meta-raspberrypi contributors
#
#   This file was copied from meta-raspberrypi page and only has minor changes.
#   They include a new data partition and set static partition sizes.
#
#   The original file can be found here: https://github.com/agherzan/meta-raspberrypi/blob/master/classes/sdcard_image-rpi.bbclass
#
#   SPDX-License-Identifier: MIT

inherit sdcard_image-rpi

IMAGE_CMD_rpi-sdimg () {

    # Align partitions
    ROOTFS_SIZE=1490944
    DATA_SIZE=1048576
    BOOT_SPACE_ALIGNED=$(expr ${BOOT_SPACE} + ${IMAGE_ROOTFS_ALIGNMENT} - 1)
    BOOT_SPACE_ALIGNED=$(expr ${BOOT_SPACE_ALIGNED} - ${BOOT_SPACE_ALIGNED} % ${IMAGE_ROOTFS_ALIGNMENT})
    SDIMG_SIZE=$(expr ${IMAGE_ROOTFS_ALIGNMENT} + ${BOOT_SPACE_ALIGNED} + $ROOTFS_SIZE + $ROOTFS_SIZE + $DATA_SIZE)

    echo "Creating filesystem with Boot partition ${BOOT_SPACE_ALIGNED} KiB and RootFS $ROOTFS_SIZE KiB"

    # Check if we are building with device tree support
    DTS="${KERNEL_DEVICETREE}"

    # Initialize sdcard image file
    dd if=/dev/zero of=${SDIMG} bs=1024 count=0 seek=${SDIMG_SIZE}

    dd if=/dev/zero of=${IMGDEPLOYDIR}/media_partition.ext3 bs=1024 count=0 seek=$DATA_SIZE

    # Create partition table
    parted -s ${SDIMG} mklabel msdos
    # Create boot partition and mark it as bootable
    parted -s ${SDIMG} unit KiB mkpart primary fat32 ${IMAGE_ROOTFS_ALIGNMENT} $(expr ${BOOT_SPACE_ALIGNED} \+ ${IMAGE_ROOTFS_ALIGNMENT})
    parted -s ${SDIMG} set 1 boot on
    # Create rootfs partition to the end of disk
    parted -s ${SDIMG} -- unit KiB mkpart primary ext2 $(expr ${BOOT_SPACE_ALIGNED} \+ ${IMAGE_ROOTFS_ALIGNMENT}) $(expr ${BOOT_SPACE_ALIGNED} \+ ${IMAGE_ROOTFS_ALIGNMENT} \+ $ROOTFS_SIZE)
    parted -s ${SDIMG} -- unit KiB mkpart primary ext2 $(expr ${BOOT_SPACE_ALIGNED} \+ ${IMAGE_ROOTFS_ALIGNMENT} \+ $ROOTFS_SIZE) $(expr ${BOOT_SPACE_ALIGNED} \+ ${IMAGE_ROOTFS_ALIGNMENT} \+ $ROOTFS_SIZE \+ $ROOTFS_SIZE)
    parted -s ${SDIMG} -- unit KiB mkpart primary ext3 $(expr ${BOOT_SPACE_ALIGNED} \+ ${IMAGE_ROOTFS_ALIGNMENT} \+ $ROOTFS_SIZE \+ $ROOTFS_SIZE) -1s
    parted ${SDIMG} print

    mkfs.ext3 -F ${IMGDEPLOYDIR}/media_partition.ext3 -b 1024

    # Create a vfat image with boot files
    BOOT_BLOCKS=$(LC_ALL=C parted -s ${SDIMG} unit b print | awk '/ 1 / { print substr($4, 1, length($4 -1)) / 512 /2 }')
    rm -f ${WORKDIR}/boot.img
    mkfs.vfat -F32 -n "${BOOTDD_VOLUME_ID}" -S 512 -C ${WORKDIR}/boot.img $BOOT_BLOCKS
    mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/bcm2835-bootfiles/* ::/
    if test -n "${DTS}"; then
        # Copy board device trees to root folder
        for dtbf in ${@split_overlays(d, True)}; do
            dtb=`basename $dtbf`
            mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/$dtb ::$dtb
        done

        # Copy device tree overlays to dedicated folder
        mmd -i ${WORKDIR}/boot.img overlays
        for dtbf in ${@split_overlays(d, False)}; do
            dtb=`basename $dtbf`
            mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/$dtb ::overlays/$dtb
        done
    fi
    if [ "${RPI_USE_U_BOOT}" = "1" ]; then
        mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/u-boot.bin ::${SDIMG_KERNELIMAGE}
        mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/boot.scr ::boot.scr
        if [ ! -z "${INITRAMFS_IMAGE}" -a "${INITRAMFS_IMAGE_BUNDLE}" = "1" ]; then
            mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}-${INITRAMFS_LINK_NAME}.bin ::${KERNEL_IMAGETYPE}
        else
            mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} ::${KERNEL_IMAGETYPE}
        fi
    else
        if [ ! -z "${INITRAMFS_IMAGE}" -a "${INITRAMFS_IMAGE_BUNDLE}" = "1" ]; then
            mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}-${INITRAMFS_LINK_NAME}.bin ::${SDIMG_KERNELIMAGE}
        else
            mcopy -i ${WORKDIR}/boot.img -s ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE} ::${SDIMG_KERNELIMAGE}
        fi
    fi

    if [ -n ${FATPAYLOAD} ] ; then
        echo "Copying payload into VFAT"
        for entry in ${FATPAYLOAD} ; do
            # add the || true to stop aborting on vfat issues like not supporting .~lock files
            mcopy -i ${WORKDIR}/boot.img -s -v ${IMAGE_ROOTFS}$entry :: || true
        done
    fi

    # Add stamp file
    echo "${IMAGE_NAME}" > ${WORKDIR}/image-version-info
    mcopy -i ${WORKDIR}/boot.img -v ${WORKDIR}/image-version-info ::

    # Deploy vfat partition
    if [ "${SDIMG_VFAT_DEPLOY}" = "1" ]; then
        cp ${WORKDIR}/boot.img ${IMGDEPLOYDIR}/${SDIMG_VFAT}
        ln -sf ${SDIMG_VFAT} ${SDIMG_LINK_VFAT}
    fi

    # Burn Partitions
    dd if=${WORKDIR}/boot.img of=${SDIMG} conv=notrunc seek=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024)
    # If SDIMG_ROOTFS_TYPE is a .xz file use xzcat
    if echo "${SDIMG_ROOTFS_TYPE}" | egrep -q "*\.xz"
    then
        xzcat ${SDIMG_ROOTFS} | dd of=${SDIMG} conv=notrunc seek=1 bs=$(expr 1024 \* ${BOOT_SPACE_ALIGNED} + ${IMAGE_ROOTFS_ALIGNMENT} \* 1024)
        xzcat ${SDIMG_ROOTFS} | dd of=${SDIMG} conv=notrunc seek=1 bs=$(expr 1024 \* ${BOOT_SPACE_ALIGNED} + ${IMAGE_ROOTFS_ALIGNMENT} \* 1024 + $ROOTFS_SIZE \* 1024)
        xzcat ${IMGDEPLOYDIR}/media_partition.ext3 | dd of=${SDIMG} conv=notrunc seek=1 bs=$(expr 1024 \* ${BOOT_SPACE_ALIGNED} + ${IMAGE_ROOTFS_ALIGNMENT} \* 1024 + $ROOTFS_SIZE \* 1024 + $ROOTFS_SIZE \* 1024)
    else
        dd if=${SDIMG_ROOTFS} of=${SDIMG} conv=notrunc seek=1 bs=$(expr 1024 \* ${BOOT_SPACE_ALIGNED} + ${IMAGE_ROOTFS_ALIGNMENT} \* 1024)
        dd if=${SDIMG_ROOTFS} of=${SDIMG} conv=notrunc seek=1 bs=$(expr 1024 \* ${BOOT_SPACE_ALIGNED} + ${IMAGE_ROOTFS_ALIGNMENT} \* 1024 + $ROOTFS_SIZE \* 1024)
        dd if=${IMGDEPLOYDIR}/media_partition.ext3 of=${SDIMG} conv=notrunc seek=1 bs=$(expr 1024 \* ${BOOT_SPACE_ALIGNED} + ${IMAGE_ROOTFS_ALIGNMENT} \* 1024 + $ROOTFS_SIZE \* 1024 + $ROOTFS_SIZE \* 1024)
    fi

    rm -rf ${IMGDEPLOYDIR}/media_partition.ext3

    # Optionally apply compression
    case "${SDIMG_COMPRESSION}" in
    "gzip")
        gzip -k9 "${SDIMG}"
        ;;
    "bzip2")
        bzip2 -k9 "${SDIMG}"
        ;;
    "xz")
        xz -k "${SDIMG}"
        ;;
    esac
}
