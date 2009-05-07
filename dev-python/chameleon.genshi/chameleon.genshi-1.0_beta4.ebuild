# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

inherit distutils

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Genshi template engine based on Chameleon"
HOMEPAGE="UNKNOWN"
SRC_URI="http://pypi.python.org/packages/source/c/${PN}/${MY_P}.tar.gz"
LICENSE="BSD"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="net-zope/zopeinterface
	net-zope/zopecomponent
	>=dev-python/zope.i18n-3.5
	>=dev-python/chameleon-core-1.0_beta21"
DEPEND="dev-python/setuptools"


S="${WORKDIR}/${MY_P}"
