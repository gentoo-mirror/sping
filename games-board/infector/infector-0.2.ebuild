# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit games

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
	dev-util/intltool
	gnome-base/librsvg
	x11-misc/xdg-utils"

src_install() {
	XDG_UTILS_INSTALL_MODE=user \
		emake DESTDIR="${D}" install \
		|| die "make install failed"

	# xdg-utils workaround
	cd "${PORTAGE_BUILDDIR}"/homedir/ || die "cd failed"
	chmod -R a+r . || die "chmod failed"
	if [[ -d .gnome/apps ]] ; then
		dodir /usr/share/gnome/apps/ || die "dodir failed"
		cp -LR .gnome/apps/* "${D}"/usr/share/gnome/apps/ || die "cp failed"
	fi
	if [[ -d .local/share ]] ; then
		dodir /usr/share/ || die "dodir failed"
		cp -LR .local/share/* "${D}"/usr/share/ || die "cp failed"
	fi
	if [[ -d .kde/share ]] ; then
		dodir /usr/share/ || die "dodir failed"
		cp -LR .kde/share/* "${D}"/usr/share/ || die "cp failed"
	fi
}
