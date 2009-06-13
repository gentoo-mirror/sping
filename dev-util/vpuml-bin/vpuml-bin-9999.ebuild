# Copyright 1999-2009 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="UML modeling tool"

HOMEPAGE="http://www.visual-paradigm.com/product/vpuml/"
SRC_URI=""

LICENSE="Visual-Paradigm-for-UML"

KEYWORDS=""
SLOT="0"
IUSE=""

RESTRICT="mirror"

installer=VP_Suite_Linux.sh

src_unpack() {
	wget "http://www.visual-paradigm.com/downloads/vpsuite/${installer}" \
		-O "${installer}" || die "wget failed"
	chmod a+x "${installer}" || die "chmod failed"
	cp "${FILESDIR}"/install_config.xml "${WORKDIR}/" || die "cp failed"
}

src_install() {
	addpredict /home/
	addpredict /root/
	addpredict /usr/local/

	dodir /usr/{bin,lib/vpuml} || die "dodir failed"

	cd "${WORKDIR}"
	./"${installer}" -q -dir "${D}/usr/lib/vpuml"
	dosym ../lib/vpuml/launcher/run_vpuml /usr/bin/vpuml || die "dosym failed"

	echo -e "edition=Community\nproduct=VP-UML" \
		> "${D}"/usr/lib/vpuml/resources/product_edition.properties \
		|| die "piping to file failed"
}
