# GObject introspection needs to run some commands on the native architecture,
# and uses qemu for this. For aarch64, these commands cause qemu to crash, so
# we disable introspection.
EXTRA_OECONF_aarch64 += "--disable-introspection"

# Wayland support is broken, so remove this until it is fixed upstream. Fixes:
# | make[3]: *** No rule to make target 'viewporter-protocol.c', needed by 'all'.  Stop.
PACKAGECONFIG_remove_aarch64 = "wayland"

DEPENDS += " glib-2.0-native "
