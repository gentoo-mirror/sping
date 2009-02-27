# Copyright 2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools versionator

MY_PV=$(get_version_component_range 1-2)

DESCRIPTION="Python bindings for Nautilus extensions"
HOMEPAGE="http://svn.gnome.org/viewcvs/nautilus-python/"
SRC_URI="http://ftp.gnome.org/pub/gnome/sources/${PN}/${MY_PV}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=gnome-base/nautilus-2.6
	>=gnome-base/eel-2.6
	>=dev-python/pygtk-2.8
	>=dev-python/gnome-python-2.12"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch ${FILESDIR}/${P}-py_lib_loc-fix.patch

	NOCONFIGURE="yes" sh autogen.sh
}

src_install() {
	emake DESTDIR="${D}" install
}
