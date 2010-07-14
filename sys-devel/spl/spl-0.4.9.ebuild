# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

AT_M4DIR=./config  # for aclocal called by eautoreconf
inherit eutils autotools

KERNEL_DIR=/usr/src/linux

DESCRIPTION="Solaris Porting Layer - a Linux kernel module providing some Solaris kernel APIs"
HOMEPAGE="http://wiki.github.com/behlendorf/spl/"
SRC_URI="http://github.com/downloads/behlendorf/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="~virtual/linux-sources-2.6.32"
RDEPEND="${DEPEND}"

require_built_kernel() {
	einfo ===========================================
	einfo Building against $(cat ${KERNEL_DIR}/include/config/kernel.release) ...
	einfo ===========================================

	for f in "${KERNEL_DIR}"/include/linux/{bounds.h,utsrelease.h} ; do
		if [[ ! -f "${f}" ]]; then
			die "File \"${f}\" missing - has that kernel been built?"
		fi
	done
}

pkg_setup() {
	require_built_kernel
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-werror.patch \
		"${FILESDIR}"/${P}-files-fdtable.patch

	eautoreconf
}

src_configure() {
	econf --with-config=all --with-linux="${KERNEL_DIR}" --with-linux-obj="${KERNEL_DIR}"
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
