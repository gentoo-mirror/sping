# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

MY_PN=bs2b

DESCRIPTION="Bauer stereophonic-to-binaural DSP library"
HOMEPAGE="http://bs2b.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/libsndfile"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install()
{
	emake install DESTDIR="${D}" || die "emake install failed"
}
