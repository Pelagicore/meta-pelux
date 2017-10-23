#
# Make sure we build with support for the broadcom driver if building for rpi
#
PACKAGECONFIG_append_rpi = " wayland-brcm "
