# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/redirfs/redirfs-0.8.ebuild,v 1.1 2010/01/19 11:26:21 cla Exp $

inherit versionator linux-mod
MY_PV=${PV##0.11_p}
MY_P="${PN}-${MY_PV}"

DESCRIPTION="The RedirFS or redirecting file system is a new layer between virtual file system switch (VFS) and file system drivers."
HOMEPAGE="http://www.redirfs.org"
SRC_URI="http://www.hartwork.org/public/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="redirfs(misc:)"
	BUILD_TARGETS="redirfs.ko"
	BUILD_PARAMS="-C ${KERNEL_DIR} M=${S} modules"
}

src_install() {
	dodoc CHANGELOG INSTALL README TODO
	linux-mod_src_install
	insinto /usr/include
	doins redirfs.h
}
