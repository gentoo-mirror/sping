# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

NEED_PYTHON="2.5"

inherit distutils

MY_PN="${PN//-/.}"

DESCRIPTION="Recipe for installing Python package distributions as eggs"
HOMEPAGE="http://pypi.python.org/pypi/zc.recipe.egg/"
SRC_URI="http://pypi.python.org/packages/source/z/${MY_PN}/${MY_PN}-${PV}.tar.gz"
LICENSE="ZPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="net-zope/zcbuildout"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS="CHANGES.txt"
