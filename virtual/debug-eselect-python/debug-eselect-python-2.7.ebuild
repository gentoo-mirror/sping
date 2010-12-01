# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

SLOT="2.7"
KEYWORDS="amd64"

DEBUG_DUMP_ACTIVE() {
	echo "DEBUG $1 $2 (slot ${SLOT}, version ${PV})"
	echo "DEBUG   \$(eselect python show --python2) = '$(eselect python show --python2)'"
	echo "DEBUG   \$(eselect python show --python3) = '$(eselect python show --python3)'"
	echo "DEBUG   \$(eselect python show) = '$(eselect python show)'"
}

eselect_python_update() {
	# Exaggerated to worst case: update of all active python versions
	eselect python update --python2
	eselect python update --python3
	eselect python update
}

pkg_postinst() {
	DEBUG_DUMP_ACTIVE Before ${FUNCNAME}

	eselect_python_update

	DEBUG_DUMP_ACTIVE After ${FUNCNAME}
}

pkg_postrm() {
	DEBUG_DUMP_ACTIVE Before ${FUNCNAME}

	eselect_python_update

	DEBUG_DUMP_ACTIVE After ${FUNCNAME}
}
