# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TurboGears development tools"
HOMEPAGE="http://www.turbogears.org/"
SRC_URI="http://www.turbogears.org/2.0/downloads/current/${MY_P}.tar.gz"
LICENSE="MIT"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND=">=dev-python/turbogears-2.0_beta7
	>=dev-python/sqlalchemy-migrate-0.5.1
	>=dev-python/sqlalchemy-0.5
	>=dev-python/repoze-what-quickstart-1.0
	>=dev-python/repoze-who-1.0.10"

S="${WORKDIR}/${MY_P}"
