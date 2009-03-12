# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4

MY_PV="f1e52457212860960122064cc008ee2f307a5797"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Darcs-like Git porcelain"

HOMEPAGE="http://repo.or.cz/w/vng.git"
SRC_URI="http://www.hartwork.org/public/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-util/git
	>=x11-libs/qt-core-4.4"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	eqmake4 || die "eqmake4 failed"
	emake || die "eqmake4 failed"
}

src_install() {
	dodoc README
	dobin vng || die "dobin failed"
}
