# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Programmable troff translator"

HOMEPAGE="http://www-rn.informatik.uni-bremen.de/software/unroff/"
SRC_URI="http://www-rn.informatik.uni-bremen.de/software/unroff/dist/${P}.tar.gz"

LICENSE="unroff"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-scheme/elk"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/src"

src_prepare() {
    epatch "${FILESDIR}"/${PN}-1.0-compile.patch
}

src_install() {
    cd "${WORKDIR}"/${P}

    insinto /usr/share/${PN}/
    doins -r scm || die 'doins failed'

    doman doc/*.1 || die 'doman failed'

    dobin src/${PN} || die 'dobin failed'
}
