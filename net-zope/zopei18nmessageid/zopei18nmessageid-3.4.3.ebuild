# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.2 (rev. 214)

inherit distutils

MY_PN="${PN/zope/zope.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope 3 i18n Message Identifier"
HOMEPAGE="http://pypi.python.org/pypi/zope.i18nmessageid"
SRC_URI="http://pypi.python.org/packages/source/z/${MY_PN}/${MY_P}.tar.gz"
LICENSE="ZPL"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="dev-python/setuptools"

S="${WORKDIR}/${MY_P}"
