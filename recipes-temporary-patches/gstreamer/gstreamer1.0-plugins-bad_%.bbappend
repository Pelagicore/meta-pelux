# GObject introspection needs to run some commands on the native architecture,
# and uses qemu for this. For aarch64, these commands cause qemu to crash, so
# we disable introspection.
EXTRA_OECONF_aarch64 += "--disable-introspection"
