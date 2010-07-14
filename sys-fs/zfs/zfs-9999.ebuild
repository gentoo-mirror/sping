# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

AT_M4DIR=./config  # for aclocal called by eautoreconf

EGIT_REPO_URI="http://github.com/behlendorf/zfs.git"
EGIT_BRANCH="top"

inherit git eutils autotools

DESCRIPTION="Native ZFS for Linux"
HOMEPAGE="http://wiki.github.com/behlendorf/zfs/"
SRC_URI=""

LICENSE="CDDL GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=sys-devel/spl-0.4.9
	>=virtual/linux-sources-2.6.32"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4.9-linking.patch
	eautoreconf
}

src_configure() {
	local kernel_dir=$(readlink -m /usr/src/linux)
	local kernel_version=${kernel_dir##/usr/src/linux-}
	local spl_dir=$(ls -1d /usr/src/spl-*/"${kernel_version}" | tail -n 1)

	einfo ===========================================
	einfo Building against ${kernel_version} ...
	einfo ===========================================

	econf --with-config=all \
			--with-linux="${kernel_dir}" --with-linux-obj="${kernel_dir}" \
			--with-spl="${spl_dir}" --with-spl-obj="${spl_dir}"/module
}

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
