# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

inherit distutils

MY_PN="${PN/-/.}"
MY_PV="${PV/_rc/rc}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Test utilities for repoze.who-powered applications"
HOMEPAGE="http://code.gustavonarea.net/repoze.who-testutil/"
SRC_URI="http://pypi.python.org/packages/source/r/${MY_PN}/${MY_P}.tar.gz"
LICENSE="Repoze"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/repoze-who-1.0
	net-zope/zopeinterface
	>=dev-python/paste-1.7
	>=dev-python/pastedeploy-1.3.3"
DEPEND=""

S="${WORKDIR}/${MY_P}"
