# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Library for XSPF playlist reading and writing"

HOMEPAGE="http://libspiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/libspiff/${P}.tar.bz2"

LICENSE="BSD LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc test"

RDEPEND=">=dev-libs/expat-1.95.8
	>=dev-libs/uriparser-0.7.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=app-doc/doxygen-1.5.8
		media-gfx/graphviz
		>=x11-libs/qt-assistant-4.0 )
	test? ( >=dev-util/libcpptest-1.1.0 )"

src_compile() {
        econf \
                $(use_enable doc) \
                $(use_enable test) \
                --disable-dependency-tracking \
                || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS

	if use doc; then
		dodir usr/share/doc/${PF}/html || die "dodir failed"
		cd "${D}"
		for i in libxspf xspf_c ; do
			mv usr/share/doc/{${i}-doc/html,${PF}/html/${i}} || die "mv failed"
			mv usr/share/doc/{${i}-doc/*.qch,${PF}/} || die "mv failed"
			rmdir usr/share/doc/${i}-doc || die "rmdir failed"
		done
	fi
}
