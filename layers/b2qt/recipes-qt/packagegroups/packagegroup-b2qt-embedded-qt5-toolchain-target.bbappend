# This is a workaround for b2qt since it doesnt officially support rocko.
# They use @contains_regex which we cannot use. We sould try to get rid
# of that hack ASAP since we completly overwrite the RDEPENDS for the
# package group instead of extending. 

RDEPENDS_${PN} = " \
    ${MACHINE_EXTRA_INSTALL_SDK} \
    packagegroup-core-standalone-sdk-target \
    'gcc-sanitizers' \
    \
    qt3d-dev \
    qt3d-runtime-dev \
    qtbase-dev \
    qtbase-staticdev \
    qtbase-doc \
    qtcanvas3d-dev \
    qtcharts-dev \
    qtconnectivity-dev \
    qtdatavis3d-dev \
    qtdeclarative-dev \
    qtdeclarative-staticdev \
    qtgamepad-dev \
    qtdeviceutilities-dev \
    qtgraphicaleffects-dev \
    qtimageformats-dev \
    qtlocation-dev \
    qtmultimedia-dev \
    qtnetworkauth-dev \
    qtotaupdate-dev \
    qtquickcontrols-dev \
    qtquickcontrols2-dev \
    qtquicktimeline-dev \
    qtremoteobjects-dev \
    qtscxml-dev \
    qtsensors-dev \
    qtserialbus-dev \
    qtserialport-dev \
    qtsvg-dev \
    qttools-dev \
    qttools-staticdev \
    qtvirtualkeyboard-dev \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland-dev', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'webengine', 'qtwebengine-dev qtwebview-dev', '', d)} \
    qtwebsockets-dev \
    qtwebchannel-dev \
    qtxmlpatterns-dev \
    "

