
#
# Reserve 512MB RAM for the GPU if this is the QtAS variant, otherwise 128MB
#
# This checks if the b2qt layer is included.
#

GPU_MEM="${@bb.utils.contains("BBFILE_COLLECTIONS", "b2qt", 512, 128, d)}"

#
# This option, together with the kernel serial command line parameter (in
# commandline.txt) enables serial console from the kernel.
#
ENABLE_UART="1"

do_deploy_append_raspberrypi3() {
    echo "# Enable audio (loads snd_bcm2835)" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
    echo "dtparam=audio=on" >> ${DEPLOYDIR}/bcm2835-bootfiles/config.txt
}
