# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Lua-based build system (used for Teeworlds)"
HOMEPAGE="http://teeworlds.com/trac/bam"
SRC_URI="http://teeworlds.com/trac/bam/browser/releases/${P}.tar.gz?format=raw -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-lang/lua"
DEPEND="${RDEPEND}
	test? ( dev-lang/python )"

src_prepare() {
	# Remove bundled Lua 5.1.4
	rm -Rf src/lua

	# _Replace_ build script
	cp -v "${FILESDIR}"/make_unix.sh "${S}"/

	epatch "${FILESDIR}"/${P}-test-suite-return-code.patch
	chmod a+x scripts/gendocs.py || die "chmod failed"
}

src_compile() {
	./make_unix.sh || die "compilation failed"
	if use doc ; then
		./scripts/gendocs.py || die "doc generation failed"
	fi
}

src_install() {
	if use doc ; then
		insinto /usr/share/doc/${PF}/
		doins docs/bam{.html,_logo.png} || die "doins failed"
	fi
	dobin src/bam || die "dobin failed"
}

src_test() {
	./scripts/test.py || die "test suite failed"
}
