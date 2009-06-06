# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit base

MY_PV=${PV/_alpha/}
MY_P="${PN}-${MY_PV}"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

DEPEND="net-misc/curl
	app-text/htmltidy
	dev-libs/uriparser"
#	metalink? (
#		libmetalink
#		checksum? ( dev-libs/openssl )
#	)
RDEPEND="${DEPEND}"

IUSE="debug" # metalink checksum
SLOT="0"

KEYWORDS="~x86"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		$(use_enable debug) \
		--disable-metalink
#		$(use_enable metalink)
#		$(use_enable checksum)
}
