# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="1"
WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-3 makeedit multilib fdo-mime autotools mozextension versionator

LANGS="af ar be bg bn-IN ca cs cy da de el en-GB en-US eo es-AR es-ES et eu fi fr fy-NL ga-IE gl gu-IN he hi-IN hu id is it ja ka kn ko ku lt lv mk mn mr nb-NO nl nn-NO oc pa-IN pl pt-BR pt-PT ro ru si sk sl sq sr sv-SE te th tr uk zh-CN zh-TW"
NOSHORTLANGS="en-GB es-AR pt-BR zh-CN"

MY_PV=${PV/_p/-g}
MY_P="${PN}-${MY_PV}"
XUL_PV="1.9.$(get_version_component_range 2-3)"
# FIREFOX_PV=$(get_version_component_range 1-3)
FIREFOX_PV="3.0.10"
FIREFOX_PN="mozilla-firefox"
FIREFOX_P="${FIREFOX_PN}-${FIREFOX_PV}"
PATCH="${FIREFOX_P}-patches-0.1"

DESCRIPTION="GNU project's edition of Mozilla Firefox"
HOMEPAGE="http://www.gnu.org/software/gnuzilla/"

KEYWORDS="~x86"
SLOT="0"
LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
IUSE="java mozdevelop restrict-javascript"

SRC_URI="mirror://gnu/gnuzilla/${MY_PV}/${MY_P}.tar.bz2
	mirror://gentoo/${PATCH}.tar.bz2
	http://dev.gentoo.org/~armin76/dist/${PATCH}.tar.bz2"

# These are in
#
#  http://releases.mozilla.org/pub/mozilla.org/firefox/releases/${PV}/linux-i686/xpi/
#
# for i in $LANGS $SHORTLANGS; do wget $i.xpi -O ${P}-$i.xpi; done
for X in ${LANGS} ; do
	if [ "${X}" != "en" ] && [ "${X}" != "en-US" ]; then
		SRC_URI="${SRC_URI}
			linguas_${X/-/_}? ( http://dev.gentoo.org/~armin76/dist/${FIREFOX_P}-xpi/${FIREFOX_P}-${X}.xpi )"
	fi
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
	if [ "${#X}" == 5 ] && ! has ${X} ${NOSHORTLANGS}; then
		if [ "${X}" != "en-US" ]; then
			SRC_URI="${SRC_URI}
				linguas_${X%%-*}? ( http://dev.gentoo.org/~armin76/dist/${FIREFOX_P}-xpi/${FIREFOX_P}-${X}.xpi )"
		fi
		IUSE="${IUSE} linguas_${X%%-*}"
	fi
done

RDEPEND="java? ( virtual/jre )
	>=sys-devel/binutils-2.16.1
	>=dev-libs/nss-3.12.2
	>=dev-libs/nspr-4.7.3
	>=app-text/hunspell-1.1.9
	>=media-libs/lcms-1.17
	>=net-libs/xulrunner-${XUL_PV}"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	java? ( >=dev-java/java-config-0.2.0 )"

PDEPEND="restrict-javascript? ( x11-plugins/noscript )"

S="${WORKDIR}/${MY_P}"

# Needed by src_compile() and src_install().
# Would do in pkg_setup but that loses the export attribute, they
# become pure shell variables.
export MOZ_CO_PROJECT=browser
export BUILD_OFFICIAL=1
export MOZILLA_OFFICIAL=1

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
	if ! built_with_use x11-libs/cairo X; then
		eerror "Cairo is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge cairo."
		die "Cairo needs X"
	fi

	if ! built_with_use --missing true x11-libs/pango X; then
		eerror "Pango is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge pango."
		die "Pango needs X"
	fi
}

src_unpack() {
	unpack ${A}

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_unpack "${FIREFOX_P}-${X}.xpi"
	done
	if [[ ${linguas} != "" && ${linguas} != "en" ]]; then
		einfo "Selected language packs (first will be default): ${linguas}"
	fi

	# Remove the patches we don't need
	rm "${WORKDIR}"/patch/*noxul*

	# Integrate rebranding
	sed -i "s|/mozilla-firefox|/icecat|" "${WORKDIR}"/patch/001-firefox_gentoo_install_dirs.patch || die "sed failed"

	# Apply our patches
	cd "${S}" || die "cd failed"
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}"/patch

	# Fix rebranding
	sed -i 's|\$(DIST)/bin/firefox|\$(DIST)/bin/icecat|' browser/app/Makefile.in || die "sed failed"

	# Use system's, not embedded xulrunner
	sed -i 's|defaults/pref/|defaults/preferences/|' browser/installer/packages-static || die "sed failed"

	eautoreconf

	# We need to re-patch this because autoreconf overwrites it
	epatch "${WORKDIR}"/patch/000_flex-configure-LANG.patch
}

icecat_mozconfig_final() {
	declare exts="default "`grep --color=never '^ac_add_options --enable-extensions=' .mozconfig \
		| sed -e 's/^ac_add_options --enable-extensions=//' \
		-e 's/#.*$//' \
		-e 's/"//g' \
		-e 's/,/ /g' \
		-e 's/default//' \
		| awk '{ printf "%s ", $0 }'`
	sed -i '/^ac_add_options --enable-extensions/d' .mozconfig
	echo "ac_add_options --enable-extensions=\"${exts}\"" >> .mozconfig
}

patch_mozconfig() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	MEXTENSIONS="default,typeaheadfind,-python/xpcom"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	# It doesn't compile on alpha without this LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"
	mozconfig_annotate '' --disable-mailnews
	mozconfig_annotate 'broken' --disable-mochitest
	mozconfig_annotate 'broken' --disable-crashreporter
	mozconfig_annotate '' --enable-system-hunspell
	#mozconfig_annotate '' --enable-system-sqlite
	mozconfig_annotate '' --enable-image-encoder=all
	mozconfig_annotate '' --enable-canvas
	mozconfig_annotate '' --with-system-nspr
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --enable-system-lcms
	mozconfig_annotate '' --enable-oji --enable-mathml
	mozconfig_annotate 'places' --enable-storage --enable-places

	# Other ff-specific settings
	#mozconfig_use_enable mozdevelop jsd
	#mozconfig_use_enable mozdevelop xpctools
	mozconfig_use_extension mozdevelop venkman
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}

	# Add xulrunner variable
	mozconfig_annotate '' --with-libxul-sdk=/usr/$(get_libdir)/xulrunner-1.9

	# Finalize and report settings
	icecat_mozconfig_final
}

src_compile() {
	cp .mozconfig{,backup}
	patch_mozconfig

	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi

	####################################
	#
	#  Configure and build
	#
	####################################

	CPPFLAGS="${CPPFLAGS} -DARON_WAS_HERE" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die

	# It would be great if we could pass these in via CPPFLAGS or CFLAGS prior
	# to econf, but the quotes cause configure to fail.
	sed -i -e \
		's|-DARON_WAS_HERE|-DGENTOO_NSPLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsplugins\\\" -DGENTOO_NSBROWSER_PLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsbrowser/plugins\\\"|' \
		"${S}"/config/autoconf.mk \
		"${S}"/toolkit/content/buildconfig.html

	# Should the build use multiprocessing? Not enabled by default, as it tends to break
	[ "${WANT_MP}" = "true" ] && jobs=${MAKEOPTS} || jobs="-j1"
	emake ${jobs} || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	einfo "Removing old installs with some really ugly code.  It potentially"
	einfo "eliminates any problems during the install, however suggestions to"
	einfo "replace this are highly welcome.  Send comments and suggestions to"
	einfo "mozilla@gentoo.org."
	rm -rf "${ROOT}"${MOZILLA_FIVE_HOME}
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"
	declare prefs=preferences

	emake DESTDIR="${D}" install || die "emake install failed"
	rm "${D}"/usr/bin/icecat

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${FIREFOX_P}-${X}"
	done

	cp "${FILESDIR}"/gentoo-default-prefs.js "${D}"${MOZILLA_FIVE_HOME}/defaults/${prefs}/all-gentoo.js || die "cp failed"

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		elog "Setting default locale to ${LANG}"
		dosed -e "s:general.useragent.locale\", \"en-US\":general.useragent.locale\", \"${LANG}\":" \
			${MOZILLA_FIVE_HOME}/defaults/${prefs}/firefox.js \
			${MOZILLA_FIVE_HOME}/defaults/${prefs}/firefox-l10n.js || \
			die "sed failed to change locale"
	fi

	# Install icon and .desktop for menu entry
	newicon "${S}"/browser/branding/unofficial/content/default.png icecat-icon.png || die "newicon failed"
	newmenu "${FILESDIR}"/icon/icecat-3.0.desktop icecat-3.0.desktop || die "newmenu failed"

	# Create /usr/bin/icecat
	cat <<EOF >"${D}"/usr/bin/icecat
#!/bin/sh
export LD_LIBRARY_PATH="${MOZILLA_FIVE_HOME}"
exec "${MOZILLA_FIVE_HOME}"/icecat "\$@"
EOF
	fperms 0755 /usr/bin/icecat
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	ewarn "All the packages built against ${PN} won't compile,"
	ewarn "if after installing ${PN} 3.0 you get some blockers,"
	ewarn "please add 'xulrunner' to your USE-flags."

	ln -s /usr/$(get_libdir)/xulrunner-1.9/defaults/autoconfig \
		${MOZILLA_FIVE_HOME}/defaults/autoconfig

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
}
