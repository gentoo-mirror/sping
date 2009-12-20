# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

MY_PV="${PV/_/}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="File system that arranges media files based their tags"
HOMEPAGE="http://www.pytagsfs.org/"
SRC_URI="http://www.alittletooquiet.net/media/release/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

S="${WORKDIR}/${MY_P}"

RDEPEND="dev-python/fuse-python
	>=dev-python/sclapp-0.5.2
	|| ( dev-python/inotifyx
		( dev-libs/libgamin[python]
			app-admin/gam-server ) )
	media-libs/mutagen"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	test? ( dev-python/inotifyx
		dev-libs/libgamin[python]
		app-admin/gam-server
		media-sound/madplay
		media-sound/vorbis-tools
		media-libs/flac
		dev-python/ctypes )"

src_test() {
	echo "$(PYTHON "${PYVER}")" setup.py test
	"$(PYTHON "${PYVER}")" setup.py test
}
