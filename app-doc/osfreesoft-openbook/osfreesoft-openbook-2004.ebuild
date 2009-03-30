# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

DESCRIPTION="O'Reilly Open Book 'Understanding Open Source and Free Software Licensing'"

HOMEPAGE="http://oreilly.com/catalog/osfreesoft/book/"
SRC_URI="http://oreilly.com/catalog/covers/0596005814_lrg.jpg
	http://oreilly.com/catalog/osfreesoft/book/appa.pdf
	http://oreilly.com/catalog/osfreesoft/book/toc.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch00.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch01.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch02.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch03.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch04.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch05.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch06.pdf
	http://oreilly.com/catalog/osfreesoft/book/ch07.pdf
	http://oreilly.com/catalog/osfreesoft/book/inx.pdf"

LICENSE="CCPL-Attribution-NoDerivs-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="bindist"

RDEPEND=""

DEPEND="app-text/pdfjam
	!bindist? ( media-gfx/imagemagick )"

src_unpack() {
	true
}

S="${WORKDIR}"

src_compile() {
	cd "${S}"
	convert "${DISTDIR}"/0596005814_lrg.jpg cover.pdf || die "convert failed"

	if ! use bindist ; then
		# Joining chapters documents together could be considered
		# a derivative work so we cannot distribute it
		pdfjoin --fitpaper false --paper letterpaper --outfile all.pdf \
			cover.pdf "${DISTDIR}"/{toc,ch0[0-7],appa,inx}.pdf
	fi
}

src_install() {
	insinto /usr/share/doc/${PF}/pdf/
	use bindist || { doins all.pdf || die "doins failed" ; }
	doins cover.pdf "${DISTDIR}"/{toc,ch0[0-7],appa,inx}.pdf || die "doins failed"
}
