# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit eutils subversion git fdo-mime

ESVN_REPO_URI="https://pcmanfm.svn.sourceforge.net/svnroot/pcmanfm/trunk"
EGIT_REPO_URI="git://git.goodpoint.de/pcmanfm-sping.git"
DESCRIPTION="Extremely fast and lightweight tabbed file manager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"
IUSE="hal healing healing-kill-sidebar-buttons"

RDEPEND="virtual/fam
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-misc/shared-mime-info
	x11-themes/gnome-icon-theme
	x11-libs/startup-notification
	hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_unpack() {
	if use healing ; then
		EGIT_BRANCH="healing"
		EGIT_TREE="${EGIT_BRANCH}"
		git_src_unpack
	elif use healing-kill-sidebar-buttons ; then
		EGIT_BRANCH="kill-sidebar-buttons"
		EGIT_TREE="${EGIT_BRANCH}"
		git_src_unpack
	else
		subversion_src_unpack
		cd "${S}"
		epatch "${FILESDIR}"/${PN}-kbshortcut.patch
	fi

	cd "${S}"
	NOCONFIGURE=1 ./autogen.sh
}

src_compile() {
	econf $(use_enable hal) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	if has_version app-admin/fam ; then
		elog "If you are using fam as your file alteration monitor, you must"
		elog "have famd started before running pcmanfm."
		elog
		elog "To add famd to the default runlevel:"
		elog "# rc-update add famd default"
		elog "To start the famd daemon now:"
		elog "# /etc/init.d/famd start"
		elog
		elog "It is recommended you use gamin instead of fam."
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
