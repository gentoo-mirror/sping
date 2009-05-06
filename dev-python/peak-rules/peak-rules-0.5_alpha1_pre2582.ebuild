# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

MY_PN="PEAK-Rules"
MY_PV=${PV/_alpha/a}
MY_PV=${MY_PV/_pre/.dev-r}
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Generic functions and business rules support systems"
HOMEPAGE="http://pypi.python.org/pypi/PEAK-Rules"
SRC_URI="http://peak.telecommunity.com/snapshots/${MY_P}.tar.gz"
LICENSE="ZPL"
KEYWORDS=""
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/bytecodeassembler-0.4
	>=dev-python/decoratortools-1.7
	>=dev-python/addons-0.6
	>=dev-python/extremes-1.1"

S="${WORKDIR}/${MY_P}"
