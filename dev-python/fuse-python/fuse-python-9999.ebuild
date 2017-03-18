# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

ECVS_SERVER="fuse.cvs.sourceforge.net:/cvsroot/fuse"
ECVS_MODULE="python"

inherit eutils distutils multilib python cvs

KEYWORDS=""
DESCRIPTION="Python FUSE bindings"
HOMEPAGE="http://fuse.sourceforge.net/wiki/index.php/FusePython"

SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=sys-fs/fuse-2.0"

S="${WORKDIR}/${ECVS_MODULE}"

src_prepare() {
	cd "${S}"
	chmod a+x setup.py || die "chmod failed"
}

pkg_postinst() {
	python_version
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/fuse.py
	python_mod_optimize \
		/usr/$(get_libdir)/python${PYVER}/site-packages/fuseparts
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages
}
