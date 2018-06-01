#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

containment = "${@bb.utils.contains('DISTRO_FEATURES', 'process-containment', 'sc', 'noop', d)}"
require qtapplicationmanager-${containment}.inc

ALLOW_EMPTY_${PN}-tools = "1"
