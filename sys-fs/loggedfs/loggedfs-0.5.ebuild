# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Fuse-filesystem which can log every operations on a filesystem"
HOMEPAGE="http://loggedfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse
	dev-libs/rlog
	dev-libs/libpcre
	dev-libs/libxml2"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	doman loggedfs.1.gz || die 'doman failed'

	insinto /usr/share/${PF}
	newins loggedfs.xml{,.sample} || die 'newins failed'

	dobin loggedfs || die 'dobin failed'
}
