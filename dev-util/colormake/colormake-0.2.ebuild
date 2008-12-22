# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=0
inherit eutils

DESCRIPTION="Colorizing wrapper around make"
HOMEPAGE="http://bre.klaki.net/programs/colormake/"
SRC_URI="http://bre.klaki.net/programs/colormake/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"
IUSE="-vanilla"
RESTRICT="mirror strip test"
DEPEND=
RDEPEND="dev-lang/perl
	sys-apps/coreutils"

S="${WORKDIR}/${PN}"

src_unpack() {
        unpack ${A}
	cd ${S}
	if ! use vanilla ; then
		epatch ${FILESDIR}/colormake-0.2-disable-broken-tagging.patch
	fi
	mv cmake colormake
}

src_compile() {
        echo ">>> Nothing to compile"
}

src_install() {
        exeinto /usr/bin
        doexe colormake.pl
        doexe colormake
}
