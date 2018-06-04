# This will skip the test for clang and mark it as not found
# It will result in qdoc not beeing build, which we don't need on the target anyway
EXTRA_QMAKEVARS_PRE += " CONFIG+=config_clang_done "
