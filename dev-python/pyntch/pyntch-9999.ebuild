# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit distutils subversion

DESCRIPTION="Static code analyzer for Python"
HOMEPAGE="http://www.unixuser.org/~euske/python/pyntch/"
SRC_URI=""
ESVN_REPO_URI="http://pyntch.googlecode.com/svn/trunk/pyntch"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

COMMON_DEPS="|| (
	dev-lang/python[xml]
	( dev-lang/python dev-python/pyxml ) )"
DEPEND="${COMMON_DEPS}"
RDEPEND="${COMMON_DEPS}"

S="${WORKDIR}/${PN}"

src_test() {
	cd "${S}"/test
	emake check || die 'emake check failed'
}
