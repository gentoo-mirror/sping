# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit games eutils

DESCRIPTION="Xiangqi (chinese chess) GUI program"

HOMEPAGE="http://code.google.com/p/hoxchess/"
SRC_URI="http://hoxchess.googlecode.com/files/HOXChess_src_v${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=x11-libs/wxGTK-2.9_pre20090418
    >=dev-libs/boost-1.3.9"

DEPEND="${RDEPEND}"

S="${WORKDIR}/hox_Project"

src_unpack() {
	unpack ${A}
	cd "${S}"

    sed \
        -e 's|\(case hoxRT_AI_PLUGIN: return \)base + "/plugins/";|\1"/usr/lib/hoxchess/";|' \
        -e 's|\(base = \)"..";|\1"/usr/share/hoxchess";|' \
        -e 's|\(prefix = \)"/resource";|\1"";|' \
        -i hox_Client/hoxUtil.cpp \
        || die "sed failed"

    # Patch out bundled boost and asio
    rm -R --interactive=never lib/{asio-*,boost_*} || die 'rm failed'
    # Fix asio include path
    # Extend list of linked libraries
    sed \
        -e 's|-I../lib/asio-[^/]\+/include|-I/usr/include/boost|' \
        -e 's|^LDFLAGS \+=.*$|\0 -lboost_thread -lboost_system|' \
        -i hox_Client/Makefile \
        || die "sed failed"
    # Fix references to asio::
    for i in hox_Client/{hoxAsyncSocket,hoxCheckUpdatesUI,hoxChesscapeConnection,hoxSocketConnection}.{cpp,h} ; do
        sed \
            -e 's|asio::error_code|boost::system::error_code|g' \
            -e 's|asio::thread|boost::thread|g' \
            -e 's|asio::|boost::asio::|g' \
            -i ${i} \
            || die "sed failed (on ${i})"
    done
    # Add line #include <boost/thread.hpp>
    for i in hox_Client/{hoxCheckUpdatesUI,hoxSocketConnection}.h ; do
        sed \
            -e 's|#include <asio.hpp>|\0\n#include <boost/thread.hpp>|' \
            -i ${i} \
            || die "sed failed (on ${i})"
    done
    for i in hox_Client/hoxCheckUpdatesUI.h ; do
        sed \
            -e 's|#include <wx/progdlg.h>|\0\n#include <boost/thread.hpp>|' \
            -i ${i} \
            || die "sed failed (on ${i})"
    done
}

src_compile() {
	for dir in {plugins/AI_*,hox_Client} ; do
		(
		cd "${dir}" && { emake || die "cd \"${dir}\" && emake failed" ; }
		)
	done
}

src_install() {
	insinto /usr/share/hoxchess/
	doins -r resource/* || die "doins failed"

	insinto /usr/lib/hoxchess/
	doins plugins/*.so || die "doins failed"

	dobin hox_Client/hoxchess || die "dobin failed"
}
