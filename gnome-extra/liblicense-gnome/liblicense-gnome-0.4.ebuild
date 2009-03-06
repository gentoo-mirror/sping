# Copyright 2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="Gnome Nautilus license integration through liblicense."
HOMEPAGE="http://sourceforge.net/projects/cctools/"
SRC_URI="mirror://sourceforge/cctools/${P}.tar.bz2"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"

IUSE=""

RDEPEND=">=media-libs/liblicense-0.4
	>=dev-python/pygtk-2.10
	>=gnome-extra/nautilus-python-0.5.0-r1"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install
}
