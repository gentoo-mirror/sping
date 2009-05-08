# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

DESCRIPTION="TurboGears 2 + tg.devtools + quickstart app dependencies"
KEYWORDS=""
SLOT="2"
IUSE=""

QUICKSTART_APP_DEPEND=">=dev-python/turbogears-2.0_beta7
	>=dev-python/catwalk-2.0.2
	>=dev-python/babel-0.9.4
	>=net-zope/zopesqlalchemy-0.4
	>=dev-python/repoze-tm2-1.0_alpha4"

RDEPEND=">=dev-python/turbogears-2
	>=dev-python/tg-devtools-2
	${QUICKSTART_APP_DEPEND}"
