# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit games eutils

DESCRIPTION="Xiangqi (chinese chess) GUI program"

HOMEPAGE="http://code.google.com/p/hoxchess/"
SRC_URI="http://hoxchess.googlecode.com/files/HOXChess_src_v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/wxGTK-2.9_pre20090418"
# TODO >=dev-libs/boost-1.3.8
# TODO >=dev-cpp/asio-1.4.1

DEPEND="${RDEPEND}"

S="${WORKDIR}/hox_Project"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed \
		-e 's|\(#define [A-Z_]\+ \+\)"../resource/\(.\+\)"|\1"/usr/share/hoxchess/\2"|' \
		-e 's|\(#define AI_PLUGINS_PATH \+\)"../plugins"|\1"/usr/lib/hoxchess"|' \
		-i hox_Client/hoxEnums.h \
		|| die "sed failed"

	sed \
		-e 's|/opt/wxGTK-2.9.0/bin/wx-config|wx-config|' \
		-i hox_Client/Makefile \
		|| die "sed failed"

	edos2unix hox_Client/hox{TablesDialog,PlayersUI}.cpp || die "edos2unix failed"
	epatch "${FILESDIR}"/${P}-compile-fix.patch
}

src_compile() {
	for dir in {plugins/AI_{XQWLight,TSITO,Folium,MaxQi},hox_Client} ; do
		(
		cd "${dir}" && { emake || die "cd \"${dir}\" && emake failed" ; }
		)
	done
}

src_install() {
	insinto /usr/share/hoxchess/
	doins -r resource/* || die "doins failed"

	insinto /usr/lib/hoxchess/
	doins plugins/*.so || die "doins failed"

	dobin hox_Client/hoxchess || die "dobin failed"
}
