# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

MY_PN="cpptest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple but powerful unit testing framework for C++"
HOMEPAGE="http://cpptest.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable doc) || die "econf failed"
	emake || die "emake failed"
}

src_install()
{
	emake install DESTDIR="${D}" || die "emake install failed"
}
