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
        -e 's|\(case hoxRT_AI_PLUGIN: return \)base + "/plugins/";|\1"/usr/lib/hoxchess/";|' \
        -e 's|\(base = \)"..";|\1"/usr/share/hoxchess";|' \
        -e 's|\(prefix = \)"/resource";|\1"";|' \
        -i hox_Client/hoxUtil.cpp \
        || die "sed failed"
}

src_compile() {
	for dir in {plugins/AI_*,hox_Client} ; do
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
