# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/mksh/mksh-36b.ebuild,v 1.1 2008/12/21 01:41:27 hanno Exp $

ECVS_AUTH=ext
ECVS_USER=_anoncvs
ECVS_SERVER=anoncvs.mirbsd.org:/cvs
ECVS_MODULE=src/bin/mksh

inherit eutils cvs

DESCRIPTION="MirBSD KSH Shell"
HOMEPAGE="http://mirbsd.de/mksh"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""
DEPEND="app-arch/cpio"
RDEPEND=""
S="${WORKDIR}/${ECVS_MODULE}"

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	wget https://www.mirbsd.org/cvs.cgi/~checkout~/contrib/code/Snippets/arc4random.c \
			--no-check-certificate -O arc4random.c \
		|| die "wget failed"
}

src_compile() {
	tc-export CC
	sh Build.sh -r || die
}

src_install() {
	exeinto /bin
	doexe mksh || die
	doman mksh.1 || die
	dodoc dot.mkshrc || die
}

src_test() {
	./test.sh || die
}
