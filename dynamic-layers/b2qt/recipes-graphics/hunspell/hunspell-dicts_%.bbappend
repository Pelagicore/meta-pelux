do_install_append() {
    install -m 0755 -d ${D}${datadir}/hunspell
 
    install -m 0755 ${S}/cs_CZ/cs_CZ.dic ${D}${datadir}/hunspell
    install -m 0755 ${S}/cs_CZ/cs_CZ.aff ${D}${datadir}/hunspell

    install -m 0755 ${S}/de/de_DE_frami.dic ${D}${datadir}/hunspell
    install -m 0755 ${S}/de/de_DE_frami.aff ${D}${datadir}/hunspell

    install -m 0755 ${S}/en/en_US.dic ${D}${datadir}/hunspell
    install -m 0755 ${S}/en/en_US.aff ${D}${datadir}/hunspell
}
