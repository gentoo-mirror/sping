# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator eutils

MY_PV=$(replace_version_separator 2 '-')
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Flow-level Traffic Generator"
HOMEPAGE="http://pages.cs.wisc.edu/~jsommers/harpoon/"
SRC_URI="http://wail.cs.wisc.edu/software/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

#TODO HAVE_FLOWTOOLS,0
DEPEND="dev-libs/expat"
RDEPEND="${DEPEND}
	dev-lang/python"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.02-122005-add-destdir-support.patch
}

src_configure() {
	econf --enable-static-plugins
}

src_compile() {
	emake src selfconf -j1 || die "emake src selfconf failed"
	use doc && {
		emake doc || die "emake doc failed"
	}
}

src_install() {
	use doc && dodoc doc/harpoon_manual.pdf

	dobin src/harpoon || die "dobin failed"
	newbin src/config_validator harpoon_config_validator || die "newbin failed"
	dobin selfconf/harpoon_flowproc || die "dobin failed"
	newbin selfconf/harpoon_reconf.py harpoon_reconf || die "newbin failed"
	newbin selfconf/synthetic.py harpoon_sythetic || die "newbin failed"
}
