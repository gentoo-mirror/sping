# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Theme for Murrine GTK+ 2.x engine known from Xubuntu"
HOMEPAGE="http://xfce-look.org/content/show.php/MurrinaStormCloud?content=61418"
SRC_URI="http://xfce-look.org/CONTENT/content-files/61418-MurrinaStormCloud-0.3.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/"

src_install() {
	insinto /usr/share/themes
	doins -r * || die "doins failed"
}
