# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

USE_RUBY="ruby18"
inherit ruby-fakegem

DESCRIPTION="Creates man pages from a subset of Markdown"
HOMEPAGE="http://rtomayko.github.com/ronn/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-ruby/hpricot-0.8.2"
RDEPEND="${DEPEND}"
