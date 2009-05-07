
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/turbogears/turbogears-1.0.8.ebuild,v 1.2 2009/04/01 11:49:33 patrick Exp $

NEED_PYTHON=2.4

inherit distutils

KEYWORDS=""

MY_PN=TurboGears2
MY_P=${MY_PN}-${PV}
[ ${PV} == 2.0 ] \
	&& MY_PV=2.0final \
	|| MY_PV=${PV}

DESCRIPTION="The rapid web development meta-framework you've been looking for."
HOMEPAGE="http://www.turbogears.org/"
SRC_URI="http://www.turbogears.org/2.0/downloads/${MY_PV}/${MY_P}.tar.gz"


LICENSE="MIT"
SLOT="0"
IUSE="test"

# this package is not yet py2.6 ready. Keep deps at =py-2.{4,5} for now.

RDEPEND=">=dev-python/pastescript-1.6.2
	test? ( >=dev-python/nose-0.9.1
		dev-python/coverage
		>=dev-python/turbokid-1.0.4
		>=dev-python/sqlalchemy-0.4
		dev-python/jinja2
		>=dev-python/chameleon-genshi-1.0_beta4
		>=dev-python/repoze-what-1.0.5
		>=dev-python/repoze-who-testutil-1.0_rc1
	)
	>=dev-python/pylons-0.9.7
	>=dev-python/genshi-0.5.1
	>=dev-python/webflash-0.1_alpha9
	>=dev-python/toscawidgets-0.9.4
	>=dev-python/weberror-0.10.1
	>=dev-python/repoze-what-pylons-1.0_rc3
	>=dev-python/repoze-tm2-1.0_alpha4
	>=dev-python/turbojson-1.2.1"

DEPEND="${RDEPEND}
	app-arch/zip
	>=dev-python/setuptools-0.6_rc5"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGELOG.txt CONTRIBUTORS.txt"

src_test() {
	#I had this fail if pylons is emerged: can't import turbogears config
	#pythonhead http://trac.turbogears.org/ticket/1774
	PYTHONPATH=. "${python}" setup.py test || die "tests failed"
}

pkg_postinst() {
	elog "While not directly depending on them, TurboGears works with/integrates"
	elog "the following packages:"
	elog " - dev-python/sqlalchemy (already installed when built with tests enabled)"
}
