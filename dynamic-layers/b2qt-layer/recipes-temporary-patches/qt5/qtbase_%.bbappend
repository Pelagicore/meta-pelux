
# Rocko change, all python occurences are now python3
do_install_prepend() {
    sed -i -e 's|/usr/bin/python$|/usr/bin/python3|' ${S}/mkspecs/features/uikit/devices.py
}
