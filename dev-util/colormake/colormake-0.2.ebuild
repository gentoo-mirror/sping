# Copyright 2008 Sebastian Pipping <sebastian@pipping.org>
# Distributed under the terms of the GNU General Public License v2
HOMEPAGE="http://bre.klaki.net/programs/colormake/"
SRC_URI="http://bre.klaki.net/programs/colormake/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"

DEPEND="dev-lang/perl"


src_unpack() {
        unpack ${A}
	cd colormake
	mv cmake colormake
}

src_compile() {
        echo ">>> Nothing to compile"
}

src_install() {
        exeinto /usr/bin
        doexe colormake/colormake.pl
        doexe colormake/colormake
}
