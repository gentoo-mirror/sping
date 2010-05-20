# Copyright 1999-2XXX Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git

DESCRIPTION="PDF Slideshow Presentation Software"
HOMEPAGE="http://repo.or.cz/w/accentuate.git"
EGIT_REPO_URI="git://repo.or.cz/accentuate.git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lirc"

DEPEND="lirc? ( dev-python/pylirc )
	dev-python/pygame
	dev-python/imaging"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${PN} || die 'dobin failed'
}
