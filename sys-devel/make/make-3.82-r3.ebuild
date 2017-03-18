# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit flag-o-matic eutils

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="http://www.gnu.org/software/make/make.html"
SRC_URI="mirror://gnu//make/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls static"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-archives-many-objs.patch #334889
	epatch "${FILESDIR}"/${P}-MAKEFLAGS-reexec.patch #31975
	epatch "${FILESDIR}"/${P}-memory-corruption.patch #355907
	epatch "${FILESDIR}"/${P}-glob-speedup.patch #382845

	epatch "${FILESDIR}"/${P}-color.patch
}

src_configure() {
	use static && append-ldflags -static
	econf \
		--program-prefix=g \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README*
	if [[ ${USERLAND} == "GNU" ]] ; then
		# we install everywhere as 'gmake' but on GNU systems,
		# symlink 'make' to 'gmake'
		dosym gmake /usr/bin/make
		dosym gmake.1 /usr/share/man/man1/make.1
	fi
}
