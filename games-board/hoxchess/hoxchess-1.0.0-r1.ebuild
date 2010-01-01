# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games eutils

DESCRIPTION="Xiangqi (chinese chess) GUI program"
HOMEPAGE="http://code.google.com/p/hoxchess/"
SRC_URI="http://hoxchess.googlecode.com/files/HOXChess_src_v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.9_pre20090418
    >=dev-libs/boost-1.3.9"
RDEPEND="${DEPEND}"

S="${WORKDIR}/hox_Project"

src_prepare() {
	# Remove files of bundled dependencies
	rm -Rf lib/{asio-*,boost_*} || die 'rm failed'

	epatch \
		"${FILESDIR}"/${P}-fix-compile-flags.patch \
		"${FILESDIR}"/${P}-fix-file-locations.patch \
		"${FILESDIR}"/${P}-migrate-to-boosts-own-asio.patch
}

src_compile() {
	for dir in plugins/AI_* hox_Client ; do
		emake -C "${dir}" || die "emake -d ${dir} failed"
	done
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}/
	doins -r resource/* || die "doins failed"

	insinto "$(games_get_libdir)"/${PN}/
	doins plugins/*.so || die "doins failed"

	dogamesbin hox_Client/hoxchess || die "dogamesbin failed"

	prepgamesdirs
}
