# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit base libtool python bash-completion

DESCRIPTION="Native makefiles generator"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://bakefile.sourceforge.net"
LICENSE="MIT"
RDEPEND=">=dev-lang/python-2.3
	>=sys-devel/autoconf-2.53"
DEPEND="${RDEPEND}"
KEYWORDS="x86 amd64"
SLOT="0"
IUSE=""

src_install () {
	base_src_install
	
	dodoc AUTHORS COPYING NEWS README THANKS
	dohtml -r doc/html/*

	dobashcompletion bash_completion bakefile
}
