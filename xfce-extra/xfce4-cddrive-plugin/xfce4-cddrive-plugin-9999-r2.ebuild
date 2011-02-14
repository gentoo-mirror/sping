# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit xfconf autotools git

XFCE_VERSION=4.4

DESCRIPTION="Panel plugin to open/close the CD-ROM drive tray"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-cddrive-plugin"
SRC_URI=""
EGIT_REPO_URI="git://git.xfce.org/panel-plugins/xfce4-cddrive-plugin"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS=""
IUSE="cddb debug"

DEPEND=">=sys-apps/hal-0.5.8.1
	>=dev-libs/dbus-glib-0.71
	>=dev-libs/glib-2.12.4
	>=xfce-base/libxfcegui4-${XFCE_VERSION}
	>=xfce-base/exo-0.3.2
	>=dev-libs/libcdio-0.76
	cddb? ( >=media-libs/libcddb-1.2.1 )"
RDEPEND="${DEPEND}
	sys-apps/hal"

src_prepare() {
	if has_version '>=xfce-base/exo-0.5' ; then
		sed 's|\(XDT_CHECK_PACKAGE(\[EXO\], \[exo-\)0\.3\(\], \[0\.3\.1\.12rc2\])\)|\11\2|' \
			-i configure.in.in \
			|| die 'sed failed (file missing)'
	fi
	sed 's|-Werror||' -i panel-plugin/Makefile.am \
		|| die 'sed failed (file missing)'

	NOCONFIGURE=true ./autogen.sh || die './autogen.sh failed'
}

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable cddb) $(use_enable !debug final)"
}

DOCS="AUTHORS ChangeLog README THANKS TODO"
