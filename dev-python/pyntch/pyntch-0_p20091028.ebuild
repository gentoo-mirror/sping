# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

MY_PV=${PV##0_p}
MY_P=${PN}-${MY_PV}
DESCRIPTION="Static code analyzer for Python"
HOMEPAGE="http://www.unixuser.org/~euske/python/pyntch/"
SRC_URI="http://www.unixuser.org/~euske/python/pyntch/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

COMMON_DEPS="|| (
	dev-lang/python[xml]
	( dev-lang/python dev-python/pyxml ) )"
DEPEND="${COMMON_DEPS}"
RDEPEND="${COMMON_DEPS}"

S=${WORKDIR}/${MY_P}

src_test() {
	cd "${S}"/test
	emake check || die 'emake check failed'
}
