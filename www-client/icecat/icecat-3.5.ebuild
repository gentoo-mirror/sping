# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib fdo-mime autotools mozextension

LANGS="af ar as be bg bn-BD bn-IN ca cs cy da de el en en-GB en-US eo es-AR
es-CL es-ES es-MX et eu fa fi fr fy-NL ga-IE gl gu-IN he hi-IN hr hu id is it ja
ka kk kn ko ku lt lv mk ml mn mr nb-NO nl nn-NO oc or pa-IN pl pt-BR pt-PT rm ro
ru si sk sl sq sr sv-SE ta-LK ta te th tr uk vi zh-CN zh-TW"
NOSHORTLANGS="en-GB es-AR es-CL es-MX pt-BR zh-CN zh-TW"

XUL_PV="1.9.1"
FIREFOX_PN="mozilla-firefox"
FIREFOX_P="${FIREFOX_PN}-${PV}"
PATCH="${FIREFOX_PN}-${PV}-patches-0.1"

DESCRIPTION="GNU project's edition of Mozilla Firefox"
HOMEPAGE="http://www.gnu.org/software/gnuzilla/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="java mozdevelop restrict-javascript" # qt-experimental

FIREFOX_REL_URI="http://releases.mozilla.org/pub/mozilla.org/firefox/releases"
SRC_URI="mirror://gnu/gnuzilla/${PV}/${P}.tar.bz2
	mirror://gentoo/${PATCH}.tar.bz2"

for X in ${LANGS} ; do
	if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? ( ${FIREFOX_REL_URI}/${PV}/linux-i686/xpi/${X}.xpi -> ${FIREFOX_P}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		if [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X%%-*}? ( ${FIREFOX_REL_URI}/${PV}/linux-i686/xpi/${X}.xpi -> ${FIREFOX_P}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

# Not working.
#	qt-experimental? (
#		x11-libs/qt-gui
#		x11-libs/qt-core )
#	=net-libs/xulrunner-${XUL_PV}*[java=,qt-experimental=]

RDEPEND="
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.2
	>=dev-libs/nspr-4.7.3
	>=dev-db/sqlite-3.6.7
	>=app-text/hunspell-1.2

	>=net-libs/xulrunner-${XUL_PV}[java=]

	>=x11-libs/cairo-1.8.8[X]
	x11-libs/pango[X]"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PDEPEND="restrict-javascript? ( x11-plugins/noscript )"

linguas() {
	local LANG SLANG
	for LANG in ${LINGUAS}; do
		if has ${LANG} en en_US; then
			has en ${linguas} || linguas="${linguas:+"${linguas} "}en"
			continue
		elif has ${LANG} ${LANGS//-/_}; then
			has ${LANG//_/-} ${linguas} || linguas="${linguas:+"${linguas} "}${LANG//_/-}"
			continue
		elif [[ " ${LANGS} " == *" ${LANG}-"* ]]; then
			for X in ${LANGS}; do
				if [[ "${X}" == "${LANG}-"* ]] && \
					[[ " ${NOSHORTLANGS} " != *" ${X} "* ]]; then
					has ${X} ${linguas} || linguas="${linguas:+"${linguas} "}${X}"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
	done
}

pkg_setup(){
	elog "libgnomebreakpad now works with ${PN} so you can debug crashes using bug-buddy"
	elog "If you don't have bug-buddy installed, ignore the gtk-warning at startup"
}

src_unpack() {
	unpack ${A}

	linguas
	for X in ${linguas}; do
		# FIXME: Add support for unpacking xpis to portage
		[[ ${X} != "en" ]] && xpi_unpack "${FIREFOX_P}-${X}.xpi"
	done
	if [[ ${linguas} != "" && ${linguas} != "en" ]]; then
		einfo "Selected language packs (first will be default): ${linguas}"
	fi
}

src_prepare() {
	# Integrate rebranding
	sed -i "s|/mozilla-firefox|/icecat|" \
		"${WORKDIR}"/001-firefox_gentoo_install_dirs.patch

	# Fix preferences location
	sed -i 's|defaults/pref/|defaults/preferences/|' browser/installer/packages-static || die "sed failed"

	# Apply our patches
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"

	# Fix rebranding
	sed -i 's|\$(DIST)/bin/firefox|\$(DIST)/bin/icecat|' browser/app/Makefile.in

	eautoreconf

	cd js/src
	eautoreconf

	# We need to re-patch this because autoreconf overwrites it
#	epatch "${WORKDIR}"/patch/000_flex-configure-LANG.patch
}

src_configure() {
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS="default"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	# Remove troublesome default options
	sed -i '/^ac_add_options --enable-extensions/d' .mozconfig
	sed -i '/^ac_add_options --enable-optimize/d' .mozconfig

	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --enable-application=browser
	mozconfig_annotate '' --disable-mailnews
	mozconfig_annotate 'broken' --disable-crashreporter
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate '' --enable-canvas
	# Bug 60668: Galeon doesn't build without oji enabled, so enable it
	# regardless of java setting.
	mozconfig_annotate '' --enable-oji --enable-mathml
	mozconfig_annotate 'places' --enable-storage --enable-places
	mozconfig_annotate '' --enable-safe-browsing

	# System-wide install specs
	mozconfig_annotate '' --disable-installer
	mozconfig_annotate '' --disable-updater
	mozconfig_annotate '' --disable-strip
	mozconfig_annotate '' --disable-install-strip

	# Use system libraries
	mozconfig_annotate '' --enable-system-cairo
	mozconfig_annotate '' --enable-system-hunspell
	mozconfig_annotate '' --enable-system-sqlite
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --enable-system-lcms
	mozconfig_annotate '' --with-system-bz2
	mozconfig_annotate '' --with-system-libxul
	mozconfig_annotate '' --with-libxul-sdk=/usr/$(get_libdir)/xulrunner-devel-${XUL_PV}

	# IUSE mozdevelop
	mozconfig_use_enable mozdevelop jsd
	mozconfig_use_enable mozdevelop xpctools
	#mozconfig_use_extension mozdevelop venkman

	# IUSE qt-experimental
#	if use qt-experimental; then
#		ewarn "You are enabling the EXPERIMENTAL qt toolkit"
#		ewarn "Usage is at your own risk"
#		ewarn "Known to be broken. DO NOT file bugs."
#		mozconfig_annotate '' --disable-system-cairo
#		mozconfig_annotate 'qt-experimental' --enable-default-toolkit=cairo-qt
#	else
		mozconfig_annotate 'gtk' --enable-default-toolkit=cairo-gtk2
#	fi

	# Other ff-specific settings
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	# Finalize and report settings
	mozconfig_final

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi

	####################################
	#
	#  Configure and build
	#
	####################################

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die
}

src_compile() {
	# Should the build use multiprocessing? Not enabled by default, as it tends to break
	[ "${WANT_MP}" = "true" ] && jobs=${MAKEOPTS} || jobs="-j1"
	emake ${jobs} || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm "${D}"/usr/bin/icecat

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${FIREFOX_P}-${X}"
	done

	cp "${FILESDIR}"/gentoo-default-prefs.js \
		"${D}"${MOZILLA_FIVE_HOME}/defaults/preferences/all-gentoo.js

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		elog "Setting default locale to ${LANG}"
		dosed -e "s:general.useragent.locale\", \"en-US\":general.useragent.locale\", \"${LANG}\":" \
			${MOZILLA_FIVE_HOME}/defaults/preferences/firefox.js \
			${MOZILLA_FIVE_HOME}/defaults/preferences/firefox-l10n.js || \
			die "sed failed to change locale"
	fi

	# Install icon and .desktop for menu entry
	newicon "${S}"/browser/base/branding/icon48.png icecat-icon.png
	newmenu "${FILESDIR}"/icon/icecat.desktop ${P}.desktop

	# Add StartupNotify=true bug 237317
	if use startup-notification; then
		echo "StartupNotify=true" >> "${D}"/usr/share/applications/${PN}-${MAJ_PV}.desktop
	fi

	# Create /usr/bin/icecat
	cat <<EOF >"${D}"/usr/bin/icecat
#!/bin/sh
export LD_LIBRARY_PATH="${MOZILLA_FIVE_HOME}\${LD_LIBRARY_PATH+":\${LD_LIBRARY_PATH}"}"
exec "${MOZILLA_FIVE_HOME}"/icecat "\$@"
EOF

	fperms 0755 /usr/bin/icecat

	# Plugins dir
	ln -s "${D}"/usr/$(get_libdir)/{nsbrowser,mozilla-firefox}/plugins
}

pkg_postinst() {
	ewarn "All the packages built against ${PN} won't compile,"
	ewarn "if after installing ${PN} 3.5 you get some blockers,"
	ewarn "please add 'xulrunner' to your USE-flags."
	elog

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
}
