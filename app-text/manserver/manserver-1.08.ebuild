# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="man pages to HTML converter and conversion server"

HOMEPAGE="http://www.squarebox.co.uk/users/rolf/download/manServer.shtml"
SRC_URI="http://www.squarebox.co.uk/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND=""

MY_PN="manServer"

S="${WORKDIR}/${MY_PN}"

src_install() {
    dodoc AUTHORS || die 'dodoc failed'
    doman ${MY_PN}.1 || die 'doman failed'
    cp ${MY_PN}.pl ${MY_PN}
    dobin ${MY_PN} || die 'dobin failed'
}
