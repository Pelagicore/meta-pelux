# Remove gbm support if we're building for rpi
PACKAGECONFIG_remove_rpi = "gbm"

# examples packageconfig is set in meta-raspberrypi
PACKAGECONFIG_remove_rpi = "examples"
