# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils gnome2-utils

DESCRIPTION="A complete, multi-colored suite of themes and icons for Linux."
HOMEPAGE="http://code.google.com/p/gnome-colors"
SRC_URI="http://gnome-colors.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

# The different themes, maybe I'll add useflags later
THEMES="colors-common brave dust human illustrious noble wine wise"

src_unpack(){
	unpack ${A}
	cd ${WORKDIR}
	for THEME in $THEMES; do
		chown root:root gnome-$THEME;
		chmod -R 755 gnome-$THEME;
	done;
}

src_install(){
	cd ${WORKDIR}
	dodir /usr/share/icons
	dodoc README AUTHORS COPYING
	for THEME in $THEMES; do
		mv "gnome-$THEME" "${D}/usr/share/icons/";
	done;
}

pkg_postinst() {
	gnome2_icon_cache_update;
}

pkg_postrm() {
	gnome2_icon_cache_update;
}

