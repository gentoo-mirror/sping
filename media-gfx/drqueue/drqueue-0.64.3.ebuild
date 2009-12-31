# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils python toolchain-funcs distutils

DESCRIPTION="Render farm managing software"
HOMEPAGE="http://www.drqueue.org/"
SRC_URI="http://drqueue.org/files/1-Sources_all_platforms/${PN}.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="X python ruby"

RDEPEND="X? ( >=x11-libs/gtk+-2 )
	 python? ( dev-lang/python )
	 ruby? ( dev-lang/ruby )
	 app-shells/tcsh"

DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	ruby? ( dev-lang/swig )
	python? ( >=dev-python/setuptools-0.6_rc6 )
	>=dev-util/scons-0.97"

pkg_setup() {
	enewgroup drqueue
	enewuser drqueue -1 /bin/tcsh /dev/null daemon,drqueue
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-mips-linux.patch \
		"${FILESDIR}"/${P}-compile-flags.patch
	if use ruby; then
		epatch "${FILESDIR}"/${P}-SConstruct.patch
	fi
}

src_compile() {
	if use X; then
		scons ${MAKEOPTS} build_drman=yes || die "scons failed"
	else
		scons ${MAKEOPTS} build_drqman=no || die "scons failed"
	fi

	if use python; then
		einfo "compiling python bindings"
		cd ${S}/python/
		distutils_src_compile
	fi

	if use ruby; then
		einfo "compiling ruby bindings"
		cd ${S}/ruby/
		ruby extconf.rb
		emake || die "emake failed"
	fi
}

pkg_preinst() {
	# stop daemons since script is being updated
	[ -n "$(pidof drqsd)" -a -x /etc/init.d/drqsd ] && \
			/etc/init.d/drqsd stop
	[ -n "$(pidof drqmd)" -a -x /etc/init.d/drqmd ] && \
			/etc/init.d/drqmd stop
}

src_install() {
	dodir /usr/share
	scons -j1 PREFIX=${D}/usr/share install || die "install failed"

	rm -R ${D}/usr/share/drqueue/bin/viewcmd || die "rm failed"

	# install {conf,init,env}.d files
	insinto /
	doins -r "${FILESDIR}"/${PV} || die "doins failed"

	# create the drqueue pid directory
	dodir /var/run/drqueue
	keepdir /var/run/drqueue

	# move etcs to /etc/drqueue
	dodir /etc/drqueue
	mv ${D}/usr/share/drqueue/etc/* ${D}/etc/drqueue
	rmdir ${D}/usr/share/drqueue/etc

	# move bins to /usr/bin
	# dodir /usr/bin
	# mv ${D}/usr/share/drqueue/bin/* ${D}/usr/bin
	# rmdir ${D}/usr/share/drqueue/bin

	if use python; then
		cd ${S}/python/
		distutils_src_install
		dodir /usr/share/${PN}/python

		# Install DRKeewee web service and example python scripts
		insinto /usr/share/${PN}/python
		doins -r DrKeewee examples || die "doins failed"
	fi

	if use ruby; then
		cd ${S}/ruby/
		emake DESTDIR=${D} install || die "emake failed"
	fi
}


pkg_postinst() {
	einfo "Edit /etc/conf.d/drqsd /etc/env.d/02drqueue"
	einfo "and /etc/conf.d/drqmd DRQUEUE_MASTER=\"hostname\""
	einfo "to reflect your master's hostname."
	einfo ""
	einfo "/etc/drqueue contains further files"
	einfo "which require configuration, mainly"
	einfo "master.conf and slave.conf."
	if use python ; then
		einfo "DrKeewee can be found in /usr/share/drqueue/python"
	fi
}
