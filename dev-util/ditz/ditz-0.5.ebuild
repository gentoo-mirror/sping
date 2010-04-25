# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

USE_RUBY="ruby18"
inherit ruby-fakegem

DESCRIPTION="DVCS-based command line issue tracker"
HOMEPAGE="http://ditz.rubyforge.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-ruby/hoe-1.7.0
	>=dev-ruby/trollop-1.9
	>=dev-ruby/rubygems-1.2.0"
RDEPEND="${DEPEND}"
