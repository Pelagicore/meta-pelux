
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
