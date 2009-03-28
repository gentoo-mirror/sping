# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="Ataxx/Hexxagon clone."

HOMEPAGE="http://${PN}.mangobrain.co.uk/"
SRC_URI="http://${PN}.mangobrain.co.uk/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.12
	>=dev-cpp/libglademm-2.6
	sys-devel/gettext"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

src_install() {
	econf || die "econf failed"
	emake DESTDIR="${D}" install || die "make install failed"
}
