# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_PN="zope.component"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope Component Architecture"
HOMEPAGE="http://pypi.python.org/pypi/zope.component"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="net-zope/zopedeprecation
	net-zope/zopeinterface
	net-zope/zopedeferredimport
	net-zope/zopeevent"
DEPEND="dev-python/setuptools
	test? ( net-zope/zopetesting )"

S="${WORKDIR}/${MY_P}"

DOCS="README.txt"
