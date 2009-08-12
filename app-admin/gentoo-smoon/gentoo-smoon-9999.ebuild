# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_BRANCH="gentoo"

inherit python eutils git

DESCRIPTION="Server side of Smolt, the Fedora hardware profiler"
HOMEPAGE="https://fedorahosted.org/smolt/"
SRC_URI=""
EGIT_REPO_URI="git://git.goodpoint.de/smolt-gentoo.git"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/python
	sys-apps/findutils"

RDEPEND="${DEPEND}
	>=virtual/mysql-5
	=dev-python/turbogears-1*
	>=dev-python/sqlalchemy-0.5
	>=dev-python/genshi-0.5.1
	dev-python/turboflot"

src_install() {
	# Yes, this is a mess.
	# For now getting it to run is more important than having it extra clean.
	# Patches welcome.

	cd "${S}/smoon"
	dodir "$(python_get_sitedir)"/smolt/server/hardware/config || die 'dodir failed'

	# Code and non-user config
	cp --parents $(find -name '*.py' -o -name '*.cfg') \
			"${D}"/"$(python_get_sitedir)"/smolt/server/ \
			|| die 'cp failed'

	# User config
	dodir /etc/smolt/ || die 'dodir failed'
	cp sample-dev.cfg "${D}"/etc/smolt/server.cfg || die 'cp failed'
	dosym /etc/smolt/server.cfg "$(python_get_sitedir)"/smolt/server/dev.cfg \
			|| die 'dosym failed'

	# Hack-fix permissions
	(
		cd "${D}"
		find . -type f -exec chmod 0644 {} + || die 'chmod failed'
		find . -mindepth 1 -type d -exec chmod 0755 {} + || die 'chmod failed'
		chown -R root: "${D}" || die 'chown failed'
	)

	# Templates, static data
	insinto "$(python_get_sitedir)"/smolt/server/hardware/
	doins -r hardware/static || die 'doins failed'
	doins -r hardware/templates || die 'doins failed'

	# Entry scripts
	dobin smoonRenderStats smoonStartHardware || die 'dobin failed'
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/"$(python_get_sitedir)"/smolt/server
}

pkg_postrm() {
	python_mod_cleanup "${ROOT}"/"$(python_get_sitedir)"/smolt/server
}
