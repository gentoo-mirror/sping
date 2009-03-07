# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt4

MY_PV="36a4448ba3bfd3a5d7385b57b4fd7457af28e718"
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
	epatch "${FILESDIR}"/${PN}-36a4448-qttest_p4.patch || die "epatch failed"
}

src_compile() {
	eqmake4 || die "eqmake4 failed"
	emake || die "eqmake4 failed"
}

src_install() {
	dodoc README
	dobin vng || die "dobin failed"
}
