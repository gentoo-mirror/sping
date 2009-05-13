# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="High Quality Reverb and Impulse Response Convolution library including XMMS/Audacious Effect plugins"

HOMEPAGE="http://freeverb3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audacious xmms plugdouble jack sse sse2 3dnow forcefpu"

RDEPEND=">=sci-libs/fftw-3.0.1
	audacious? ( >=media-libs/libsndfile-1.0.11 )
	xmms?      ( >=media-libs/libsndfile-1.0.11 )
	jack?      ( >=media-libs/libsndfile-1.0.11 )
	audacious? ( media-sound/audacious )
	xmms?      ( media-sound/xmms )
	jack?      ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}"

src_compile() {
	econf \
		--enable-release \
		$(use_enable audacious) \
		--disable-bmp \
		$(use_enable xmms) \
		$(use_enable jack) \
		$(use_enable plugdouble) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable 3dnow) \
		$(use_enable forcefpu) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
