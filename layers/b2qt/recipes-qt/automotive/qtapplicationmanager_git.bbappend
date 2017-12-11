#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#
SRCREV = "9295baad5f20cf7b3e12aad37e7255a143b0c89b"

containment = "${@bb.utils.contains('DISTRO_FEATURES', 'process-containment', 'sc', 'noop', d)}"
require qtapplicationmanager-${containment}.inc
