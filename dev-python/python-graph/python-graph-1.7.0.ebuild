# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Library for working with graphs in Python"
HOMEPAGE="http://code.google.com/p/python-graph/"
SRC_URI="http://python-graph.googlecode.com/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="" # TODO tests

DEPEND=""
RDEPEND=""

src_compile() {
	for subdir in core dot ; do
		cd "${S}"/${subdir}
		distutils_src_compile
	done
}

src_install() {
	for subdir in core dot ; do
		cd "${S}"/${subdir}
		distutils_src_install
	done
	cd "${S}"

	insinto /usr/share/${PF}/doc
	doins docs/* || die 'doins failed'
	
	dodoc README Changelog || die 'dodoc failed'
}
