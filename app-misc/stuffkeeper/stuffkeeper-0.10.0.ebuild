# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Stuffkeeper is a generic catalog program."
HOMEPAGE="http://stuffkeeper.org"
SRC_URI="http://download.sarine.nl/Programs/StuffKeeper/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="spell"

DEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.10
	>=dev-db/sqlite-3
	>=gnome-base/libglade-2.6
	dev-util/gob
	dev-util/intltool
	spell? ( app-text/gtkspell )"
RDEPEND="${DEPEND}"

src_compile() {
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi

	./configure \
		--prefix=/usr
}

src_install() {
	dodoc AUTHORS LICENSE
	emake DESTDIR="${D}" install || die "emake install failed"
}
