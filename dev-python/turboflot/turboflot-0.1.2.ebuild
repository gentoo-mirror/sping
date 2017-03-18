# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit distutils

MY_PN="TurboFlot"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A TurboGears widget for Flot, a jQuery plotting library"
HOMEPAGE="UNKNOWN"
SRC_URI="mirror://pypi/T/${MY_PN}/${MY_P}.tar.bz2"
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/turbogears-1.0.3.2
	<dev-python/turbojson-1.2"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
