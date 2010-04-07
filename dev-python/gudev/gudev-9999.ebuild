# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git

DESCRIPTION="Python binding to the GUDev udev helper library"
HOMEPAGE="http://github.com/nzjrs/python-gudev"
SRC_URI=""
EGIT_REPO_URI="git://github.com/nzjrs/python-gudev.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=sys-fs/udev-147
	dev-python/pygobject
	dev-lang/python"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	NOCONFIGURE=true ./autogen.sh || die 'autogen.sh failed'
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake failed'
}
