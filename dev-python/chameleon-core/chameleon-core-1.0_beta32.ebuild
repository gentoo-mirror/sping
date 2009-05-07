# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.2 (rev. 214)

inherit distutils

MY_PN="chameleon.core"
MY_PV="${PV/_beta/b}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Attribute language template compiler"
HOMEPAGE="UNKNOWN"
SRC_URI="http://pypi.python.org/packages/source/c/${MY_PN}/${MY_P}.tar.gz"
LICENSE="BSD"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="dev-python/setuptools
	net-zope/zopeinterface
	>=net-zope/zopei18n-3.5
	>=dev-python/sourcecodegen-0.6.7"

S="${WORKDIR}/${MY_P}"
