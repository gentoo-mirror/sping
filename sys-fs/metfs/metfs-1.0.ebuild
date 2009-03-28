# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="Single-file RC4-based encrypted file system for FUSE."

HOMEPAGE="http://www.enderunix.org/metfs/"
SRC_URI="http://www.enderunix.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="sys-fs/fuse
	dev-libs/libgcrypt
	dev-libs/libtar"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack $A
	cd "${S}"

	sed -i 's|/usr/local/lib/libtar.a|-ltar|' configure || die "sed failed"
}

src_install() {
	dodoc AUTHORS ChangeLog README TODO || die "dodoc failed"
	dobin metfs || die "dodir failed"
}
