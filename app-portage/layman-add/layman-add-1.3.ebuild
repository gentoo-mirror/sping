# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Easy installation of Gentoo overlays"
HOMEPAGE="http://git.goodpoint.de/?p=layman-add.git;a=summary"
SRC_URI="http://git.goodpoint.de/?p=layman-add.git;a=blob_plain;f=layman-add;hb=c3f0d2e170f8c15f837f749780f2b025611a854b;/layman-add"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-portage/layman"
DEPEND=${RDEPEND}

src_install() {
	cd "${DISTDIR}"
	dobin layman-add
}
