# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit versionator

SLOT=$(get_version_component_range 1-2)
KEYWORDS="amd64"

for stage in src_{unpack,prepare,configure,compile,install} pkg_{config,setup,{pre,post}{inst,rm}} ; do
	eval "${stage}"'() {	ewarn "STAGE ${FUNCNAME} (slot ${SLOT}, version ${PV})" ; }'
done
