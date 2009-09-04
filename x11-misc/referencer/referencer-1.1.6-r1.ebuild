# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils autotools fdo-mime

DESCRIPTION="Gnome application to organise documents or references, and to
generate BibTeX bibliography files."
HOMEPAGE="http://icculus.org/referencer/"
SRC_URI="http://icculus.org/referencer/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/poppler-0.5.0
	>=dev-cpp/gtkmm-2.8
	>=dev-cpp/libgnomeuimm-2.14.0
	>=dev-cpp/gnome-vfsmm-2.14.0
	>=dev-cpp/libglademm-2.6.0
	>=dev-cpp/gconfmm-2.14.0
	virtual/poppler-glib
	dev-libs/boost
	dev-lang/python"
DEPEND="${RDEPEND}
    >=app-text/gnome-doc-utils-0.3.2
    dev-util/pkgconfig
    dev-util/intltool
    app-text/rarian"

src_configure() {
	econf --disable-update-mime-database --enable-python
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed!"
	dodoc AUTHORS ChangeLog NEWS README TODO  || die
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
