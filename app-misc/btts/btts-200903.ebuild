# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="'Back to the sources' music disk by NightRadio"

HOMEPAGE="http://www.warmplace.ru/music/${PN}/"
SRC_URI="http://www.warmplace.ru/music/${PN}/${PN}.zip"

LICENSE="BSD xman"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	media-libs/alsa-lib"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
	cd "${S}"/sources/${PN}/make || die "cd failed"
	emake linux || die "emake failed"
}

src_install() {
	insinto /usr/share/${PF}/
	doins data/* || die "doins failed"

	exeinto /usr/lib/${PF}/
	doexe sources/${PN}/make/${PN} || die "doexe failed"
	dosym /usr/share/${PF}/ /usr/lib/${PF}/data

	cat <<EOF >${PN}
#! /bin/sh
(
cd /usr/lib/${PF}/ || exit 1
/usr/lib/${PF}/${PN}
)
EOF
	dobin ${PN} || die "dobin failed"

	mv info_en.txt README
	dodoc README || die "dodoc failed"
}
