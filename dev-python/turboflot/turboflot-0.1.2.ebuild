# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.2 (rev. 214)

inherit distutils

MY_PN="TurboFlot"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A TurboGears widget for Flot, a jQuery plotting library"
HOMEPAGE="UNKNOWN"
SRC_URI="http://pypi.python.org/packages/source/T/${MY_PN}/${MY_P}.tar.bz2"
LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/turbogears-1.0.3.2"
DEPEND=""

S="${WORKDIR}/${MY_P}"
