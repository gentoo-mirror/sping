# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

AT_M4DIR=./config  # for aclocal called by eautoreconf
inherit eutils autotools

KERNEL_VERSION=2.6.32-gentoo-r12
KERNEL_DIR=/usr/src/linux-${KERNEL_VERSION}
SPL_DIR=/usr/src/spl-0.4.9/${KERNEL_VERSION}/

DESCRIPTION="Native ZFS for Linux"
HOMEPAGE="http://wiki.github.com/behlendorf/zfs/"
SRC_URI="http://github.com/downloads/behlendorf/${PN}/${P}.tar.gz"

LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="=sys-devel/spl-0.4.9
	=sys-kernel/gentoo-sources-2.6.32-r12"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-linking.patch
	
	eautoreconf
}

src_configure() {
	econf --with-config=all \
			--with-linux="${KERNEL_DIR}" --with-linux-obj="${KERNEL_DIR}" \
			--with-spl="${SPL_DIR}" --with-spl-obj="${SPL_DIR}/module"
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
