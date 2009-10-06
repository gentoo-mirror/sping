# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit cmake-utils

DESCRIPTION="Collection-oriented music player using Qt3 and xinelib."
HOMEPAGE="http://boombox.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="x11-libs/qt:3
	media-libs/xine-lib
	media-libs/taglib
	>=dev-db/sqlite-3.0"

DEPEND="${RDEPEND}
	dev-util/cmake"

mycmakeargs='-DQT_MOC_EXECUTABLE:FILEPATH=/usr/qt/3/bin/moc'
