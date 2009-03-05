# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uriparser/uriparser-0.7.4.ebuild,v 1.1 2009/03/01 18:14:03 patrick Exp $

DESCRIPTION="Uriparser is a strictly RFC 3986 compliant URI parsing library in C"

HOMEPAGE="http://uriparser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc test"

RDEPEND=""
DEPEND="dev-util/pkgconfig
	doc? ( >=app-doc/doxygen-1.5.8
		>=x11-libs/qt-assistant-4.0 )
	test? ( >=dev-util/libcpptest-1.1.0 )"

src_compile() {
	econf \
		$(use_enable doc) \
		$(use_enable test) \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF}/ \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog THANKS doc/*.txt
	dohtml doc/*.htm

	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins doc/*.qch  # Avoiding dodoc's compression
	fi
}
