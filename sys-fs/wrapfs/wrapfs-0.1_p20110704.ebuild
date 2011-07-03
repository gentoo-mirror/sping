# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit linux-mod

DESCRIPTION="Stackable passthru file system for Linux."
HOMEPAGE="http://wrapfs.filesystems.org/"
SRC_URI="http://www.hartwork.org/public/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	linux-mod_pkg_setup
	MODULE_NAMES="wrapfs(extra:)"
	BUILD_TARGETS="wrapfs.ko"
	BUILD_PARAMS="-C ${KERNEL_DIR} M=${S} modules"
}

src_install() {
	dodoc AUTHORS README
	linux-mod_src_install
}
