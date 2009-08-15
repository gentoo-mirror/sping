# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Wrapper around manServer (app-text/manserver)"

HOMEPAGE="http://git.goodpoint.de/?p=man2tidyhtml.git;a=summary"
SRC_URI="http://www.hartwork.org/public/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/python
    || ( =app-text/manserver-1.07
        =app-text/manserver-1.08 )
    dev-python/utidylib"
DEPEND=""

S="${WORKDIR}/${PN}"

src_install() {
    dodoc AUTHORS || die 'dodoc failed'
    dobin ${PN} || die 'dobin failed'
}
