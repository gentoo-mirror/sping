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
	local eselect_python_options
	[[ "$(eselect python show)" == "python2."* ]] && eselect_python_options="--python2"

	# Create python2 symlink.
	eselect python update --python2 > /dev/null

	eselect python update ${eselect_python_options}
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
