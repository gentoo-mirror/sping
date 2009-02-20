# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

MY_PN="SFML"

DESCRIPTION="Simple and fast multimedia library"
HOMEPAGE="http://sfml.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${MY_PN}-${PV}-sdk-linux.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/freetype
	media-libs/libsndfile
	media-libs/openal
	media-libs/jpeg
	media-libs/libpng
	media-libs/glew
	sys-libs/zlib"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack()
{
	unpack ${A}
	cd "${S}"
	rm -f lib/*.so.*
	rm -Rf src/SFML/Graphics/{GLEW,lib{jpeg,png},zlib}
	epatch "${FILESDIR}"/${PN}-1.4-destdir-r5.patch || die "epatch failed"
	epatch "${FILESDIR}"/${PN}-1.4-deps.patch || die "epatch failed"
}

src_install()
{
	emake install DESTDIR="${D}" prefix=/usr || die "emake install failed"
}
