# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Replacement for GNU seq and BSD jot"
HOMEPAGE="https://fedorahosted.org/enum/"
SRC_URI="https://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/asciidoc"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die 'emake install'
}
