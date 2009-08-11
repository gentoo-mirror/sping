# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smolt/smolt-1.2.ebuild,v 1.3 2009/04/22 20:22:01 maekke Exp $

EGIT_BRANCH="gentoo"

inherit python eutils git

DESCRIPTION="The Fedora hardware profiler"
HOMEPAGE="https://fedorahosted.org/smolt/"
SRC_URI=""
EGIT_REPO_URI="git://git.goodpoint.de/smolt-gentoo.git"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="qt4"

DEPEND="virtual/python
	sys-devel/gettext
	qt4? ( dev-python/PyQt4 )"

RDEPEND="${DEPEND}
	sys-apps/hal
	>=dev-python/rhpl-0.213
	>=dev-python/urlgrabber-3.0.0
	>=dev-python/simplejson-1.7.1
	dev-python/dbus-python"

src_install() {
	cd "${S}/client"
	emake install DESTDIR="${D}" || die "Install failed"

	if ! use qt4; then
		rm "${D}"/usr/bin/smoltGui
		rm "${D}"/usr/share/smolt/client/smoltGui.py
		rm "${D}"/usr/share/smolt/client/gui.py
	fi

	# Take over handling of man pages
	rm "${D}"/usr/share/man/man1/*
	for i in man/*.1.gz ; do gunzip $i ; done
	doman man/smolt{SendProfile,DeleteProfile}.1
	use qt4 && doman man/smoltGui.1

	dodoc ../README ../TODO ../doc/PrivacyPolicy
	newinitd "${FILESDIR}"/smolt-init.d ${PN} || die "newinitd failed"
}

pkg_postinst() {
	python_mod_optimize "${ROOT}"/usr/share/${PN}

	if ! [ -f "${ROOT}"/etc/smolt/hw-uuid ]; then
		elog "Creating this machines UUID in ${ROOT}/etc/smolt/hw-uuid"
		cat /proc/sys/kernel/random/uuid > "${ROOT}"/etc/smolt/hw-uuid
		UUID=$(cat "${ROOT}"/etc/smolt/hw-uuid)
		elog "Your UUID is: ${UUID}"
	fi
	echo
	elog "Call smoltSendProfile as root in order to initialize your profile."
	echo
	elog "You can withdraw it from the server if you wish to with"
	elog "   smoltDeleteProfile any time later on."
	echo

	if use qt4 && has_version "<virtual/python-2.5"; then
		elog "If you want to view your profile on the web from within smoltGui,"
		elog "you should have a link mozilla-firefox -> firefox in your path."
		echo
	fi
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
