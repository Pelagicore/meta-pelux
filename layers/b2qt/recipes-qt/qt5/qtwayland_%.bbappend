#
# Make sure we build with support for the broadcom driver if building for rpi
#
PACKAGECONFIG_append_rpi = " wayland-brcm "

# Build examples for wayland since they provide a sample compositor which is handy
# to test the graphic setup
PACKAGECONFIG_append = " examples "
