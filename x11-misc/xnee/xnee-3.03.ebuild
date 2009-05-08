# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnee/xnee-3.02.ebuild,v 1.3 2009/05/02 09:42:00 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Program suite to record, replay and distribute user actions."
HOMEPAGE="http://www.sandklef.com/xnee"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome gtk xosd doc"  # TODO doc compilation broken

RDEPEND="x11-libs/libX11
	x11-libs/libXtst
	gtk? ( >=x11-libs/gtk+-2 )
	gnome? ( gnome-base/gconf
		gnome-base/gnome-panel )"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	dev-util/pkgconfig
	gtk? ( sys-devel/gettext media-gfx/imagemagick )
	doc? (
		app-office/dia
		app-text/texi2html
		sys-apps/texinfo
		virtual/ghostscript
		app-text/texlive-core
	)"

src_configure() {
	local myconf

	if use xosd; then
		myconf="--enable-xosd --enable-verbose --enable-buffer_verbose"
	else
		myconf="--disable-xosd --disable-verbose --disable-buffer_verbose"
	fi

	econf ${myconf} --enable-cli --enable-lib \
		$(use_enable gnome gnome-applet) \
		$(use_enable gtk gui) \
		$(use_enable doc)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README TODO

	if use gtk; then
		doicon pixmap/${PN}.png
		make_desktop_entry gnee Gnee ${PN} "Utility;GTK"
	fi
}
