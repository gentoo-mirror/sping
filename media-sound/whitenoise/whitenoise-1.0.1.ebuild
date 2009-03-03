# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Small utility which turns your computer into an ambient random
noise generator."
HOMEPAGE="http://www.eecs.umich.edu/~pelzlpj/whitenoise/"
SRC_URI="http://www.eecs.umich.edu/~pelzlpj/whitenoise/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="fftw arts doc"

DEPEND="
	fftw? ( sci-libs/fftw )
	arts? ( kde-base/arts )
"
RDEPEND=""

src_compile() {
	econf ${myconf} \
		$(use_enable fftw) \
		$(use_enable arts)

	emake || die "emake failed"
}

src_install() {
	into ${PREFIX}
	dobin whitenoise
	use doc && dodoc doc/manual.html doc/HACKING
}
