# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils autotools

MY_P=ocs-${PV}

DESCRIPTION="OPAL functional programming language"
HOMEPAGE="http://uebb.cs.tu-berlin.de/~opal/"
SRC_URI="http://projects.uebb.tu-berlin.de/opal/trac/raw-attachment/wiki/OCS/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"

IUSE="X doc +tk +tcl"

DEPEND=">=sys-libs/readline-4.3-r5
	>=sys-libs/ncurses-5.4-r5
	doc?       ( >=app-text/tetex-2 )
	tk?        ( >=dev-lang/tcl-8.4.6 )
	tcl?       ( >=dev-lang/tk-8.4.6-r1 )
	"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		$(use_enable doc) \
		$(use_enable doc dosfop) \
		$(use_enable tk opalwin) \
		$(use_enable tcl oasys) \
		--enable-dynamic \
		--disable-absolute-pathes \
		--enable-reflections \
		--prefix="${D}/usr" \
		|| die "./configure failed"
}

src_compile() {
    :
}

src_install() {
	# chmod:     /var <-- Prevent access violation
	addpredict /var
	mkdir -p "${D}/usr/"

	emake -j1 install || die "make failed"
}
