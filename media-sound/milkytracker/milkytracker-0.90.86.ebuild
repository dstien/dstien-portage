# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit autotools eutils

DESCRIPTION="FastTracker 2 inspired music tracker"
HOMEPAGE="http://milkytracker.org/"
SRC_URI="http://milkytracker.org/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa jack"

RDEPEND=">=media-libs/libsdl-1.2
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-alsalibs.patch"
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with alsa) \
		$(use_with jack)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS docs/readme_unix
	dohtml docs/{ChangeLog,FAQ,MilkyTracker}.html

	newicon resources/pictures/carton.png ${PN}.png
	make_desktop_entry ${PN} MilkyTracker ${PN} \
		"AudioVideo;Audio;Sequencer"
}
