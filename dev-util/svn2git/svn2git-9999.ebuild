# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit qt4-r2 git

DESCRIPTION="Importer for one time conversion from svn to git."
HOMEPAGE="http://gitorious.org/svn2git/svn2git"
EGIT_REPO_URI="git://gitorious.org/svn2git/svn2git.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-util/subversion"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's|^\(APR_INCLUDE = /usr/include/apr-1\)\.0|\1|' "${S}"/src/src.pro
}

src_install() {
	insinto /usr/share/${PN}/samples
	doins samples/*.rules || die 'doins failed'
	dobin svn-all-fast-export || die 'dobin failed'
	dosym svn-all-fast-export /usr/bin/svn2git || die 'dosym failed'
}
