# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git

DESCRIPTION="A GTK based repository browser for git "
HOMEPAGE="http://github.com/pta/gitscene"
EGIT_REPO_URI="git://github.com/pta/gitscene.git"
SRC_URI=""

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python
	dev-python/pygtk
	dev-python/pycairo
	dev-python/pygobject
	dev-python/pygtksourceview"
RDEPEND="${DEPEND}"

src_install() {
	newdoc gitscene README || 'newdoc failed'
	dobin gitscene || die 'dobin failed'
}
