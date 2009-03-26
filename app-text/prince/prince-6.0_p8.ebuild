# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

MY_P="${P/_p/r}-linux"

DESCRIPTION="Converts XML/HTML to PDF."

HOMEPAGE="http://www.princexml.com/"
SRC_URI="http://www.princexml.com/download/${MY_P}.tar.gz"
LICENSE="Prince-EULA"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/destdir.patch"
}

src_install() {
	DESTDIR="${D}" ./install.sh <<<'/usr'
}
