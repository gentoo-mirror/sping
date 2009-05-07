# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.2 (rev. 214)

inherit distutils

MY_PN="z3c.recipe.sphinxdoc"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Use Sphinx to build documentation for zope.org."
HOMEPAGE="http://pypi.python.org/pypi/z3c.recipe.sphinxdoc/"
SRC_URI="http://pypi.python.org/packages/source/z/${MY_PN}/${MY_P}.tar.gz"
LICENSE="ZPL"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND="dev-python/setuptools
	net-zope/zcbuildout
	dev-python/zc-recipe-egg
	dev-python/docutils
	dev-python/sphinx"

S="${WORKDIR}/${MY_P}"
