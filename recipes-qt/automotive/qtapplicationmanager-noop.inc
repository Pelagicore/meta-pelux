#
#   Copyright (C) 2017 Pelagicore AB
#   SPDX-License-Identifier: MIT
#

# This file is intentionally left blank: it is sourced by the _append recipe for
# qtapplicationmanager when the softwarecontainer plugin is disabled. This file
# is needed because the "require" directive would fail otherwise; and on the
# other hand, we want to use the "require" directory (instead of just
# "include") because we want an error to be generated if, for any reason, the
# qtapplicationmanager-sc.inc file is not found.
