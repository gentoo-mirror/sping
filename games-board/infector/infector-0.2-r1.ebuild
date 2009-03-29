# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit games

DESCRIPTION="Ataxx/Hexxagon clone."

HOMEPAGE="http://infector.mangobrain.co.uk/"
SRC_URI="http://infector.mangobrain.co.uk/downloads/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.12
	>=dev-cpp/libglademm-2.6"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	gnome-base/librsvg
	x11-misc/xdg-utils"

copy_stuff() {
	if [[ -d "$1" ]] ; then
		dodir "$2" || die "dodir failed"
		cp -LR "$1"/* "${D}"/"$2" || die "cp failed"
	fi
}

src_install() {
	XDG_UTILS_INSTALL_MODE=user \
		emake DESTDIR="${D}" install \
		|| die "make install failed"

	# xdg-utils workaround
	cd "${PORTAGE_BUILDDIR}"/homedir/ || die "cd failed"
	chmod -R a+r . || die "chmod failed"
	copy_stuff .gnome/apps /usr/share/gnome/apps/
	copy_stuff .local/share /usr/share/
	copy_stuff .kde/share /usr/share/
}
