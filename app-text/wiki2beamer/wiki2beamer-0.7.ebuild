# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Tool to produce LaTeX Beamer code from wiki-like input."

HOMEPAGE="http://wiki2beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}"

src_install() {
	cd code/
	dodoc ChangeLog README || die "dodoc failed"
	dobin wiki2beamer || die "dobin failed"

	cd ../doc/man
	doman wiki2beamer.1 || die "doman failed"
}
