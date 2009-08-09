# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base autotools

DESCRIPTION="Slide show presentation tool"

HOMEPAGE="http://code.google.com/p/xsw/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="pdf"

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-image
	media-libs/sdl-gfx"
RDEPEND="${DEPEND}
	pdf? ( media-gfx/imagemagick )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.3.5-fix-destdir-remove-usr-local-stuff.patch
	eautomake
}

src_install() {
	base_src_install
	dodoc ChangeLog NEWS README REFERENCE THANKS TODO || die 'dodoc failed'
}
