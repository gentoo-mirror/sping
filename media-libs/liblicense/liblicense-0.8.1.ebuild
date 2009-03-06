# Copyright 2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools

DESCRIPTION="A library for managing license metadata"
HOMEPAGE="http://wiki.creativecommons.org/Liblicense"
SRC_URI="http://mirrors.creativecommons.org/software/${PN}/${P}.tar.gz
	mirror://sourceforge/cctools/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"

IUSE="xmp mp3 ruby python flac vorbis xml ole taglib gnome sqlite3"

RDEPEND=">=media-libs/raptor-1.0
 	xmp? ( >=media-libs/exempi-0.99.3 )
	mp3? ( >=media-libs/id3lib-3.0 )
	ruby? ( >=dev-lang/ruby-1.2 )
	python? ( >=dev-lang/python-2.4 )
	flac? ( >=media-libs/flac-1.0 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	xml? ( >=dev-libs/libxml2-2.4 )
	ole? ( >=gnome-extra/libgsf-1.12 )
	taglib? ( >=media-libs/taglib-1.4 )
	gnome? ( >=gnome-extra/nautilus-python-0.4.3 )
	sqlite3? ( =dev-db/sqlite-3* )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	echo "license_LDFLAGS = -ldl" >> utils/Makefile.am || die "patching failed"
	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf \
		$(use_enable python) \
		$(use_enable ruby) \
		$(use_enable xml libxml2) \
		$(use_enable xmp) \
		$(use_enable mp3 id3) \
		$(use_enable flac FLAC) \
		$(use_enable vorbis) \
		$(use_enable ole gsf) \
		$(use_enable taglib) \
		$(use_enable sqlite3 sqlite) \
		|| die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
