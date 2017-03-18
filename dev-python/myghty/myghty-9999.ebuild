# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

PYTHON_DEPEND="2:2.4"

ESVN_REPO_URI="http://svn.myghty.org/myghty/trunk/"

inherit distutils subversion

KEYWORDS=""

MY_PN=Myghty
MY_P=${MY_PN}-${PV}

DESCRIPTION="Template and view-controller framework derived from HTML::Mason."
HOMEPAGE="http://www.myghty.org"
SRC_URI=""
LICENSE="MIT"
SLOT="0"
IUSE="doc test"

RDEPEND=">=dev-python/routes-1.0
	dev-python/paste
	dev-python/pastedeploy
	dev-python/pastescript"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

src_compile() {
	distutils_src_compile
	if use doc ; then
		einfo "Generation docs as requested..."
		cd doc
		PYTHONPATH=./lib/ python genhtml.py || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install
	use doc && dohtml doc/html/*
}

src_test() {
	PYTHONPATH=./lib/ "${python}" test/alltests.py || die "tests failed"
}
