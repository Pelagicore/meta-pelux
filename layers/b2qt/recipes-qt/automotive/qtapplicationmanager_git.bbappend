#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

containment = "${@bb.utils.contains('DISTRO_FEATURES', 'process-containment', 'sc', 'noop', d)}"
require qtapplicationmanager-${containment}.inc

SRCREV = "5c08826b6c794fe67ed2ebecca4a53ecf918ecca"

ALLOW_EMPTY_${PN}-tools = "1"
