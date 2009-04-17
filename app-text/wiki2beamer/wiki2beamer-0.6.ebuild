# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Tool to produce LaTeX Beamer code from wiki-like input."

HOMEPAGE="http://wiki2beamer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${PN}"

RDEPEND="dev-lang/python"
DEPEND=""

src_install() {
	mv changelog.txt ChangeLog
	mv readme.txt README
	dodoc ChangeLog README || die "dodoc failed"

	mv wiki2beamer.py wiki2beamer
	dobin wiki2beamer || die "dobin failed"
}
